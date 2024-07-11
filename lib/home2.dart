import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const MethodChannel pytorchChannel = MethodChannel('com.pytorch_channel');

  List<ResultObjectDetection?> objDetect = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String documentsPath = 'assets/models';
  bool isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    _gettingModelFile().then((void value) => print('File Created Successfully'));
  }

  Future<void> _gettingModelFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      documentsPath = directory.path;
    });

    final String modelPath = join(directory.path, 'best.pt');
    final ByteData data = await rootBundle.load('assets/models/best.pt');

    final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    if (!File(modelPath).existsSync()) {
      await File(modelPath).writeAsBytes(bytes);
    }

    setState(() {
      isModelLoaded = true;
    });
  }

  Future<void> runObjectDetection() async {
    if (!isModelLoaded) {
      print('Model is not loaded yet');
      return;
    }

    if (_image == null) {
      print('No image selected');
      return;
    }

    final ByteData imageData = await _image!.readAsBytes().then((value) => ByteData.view(value.buffer));
    try {
      final List<dynamic> result = await pytorchChannel.invokeMethod(
        'detect_objects',
        <String, dynamic>{
          'model_path': '$documentsPath/best.pt',
          'image_data': imageData.buffer.asUint8List(),
        },
      );

      setState(() {
        objDetect = result.map((item) => ResultObjectDetection.fromMap(Map<String, dynamic>.from(item))).toList();
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Disease Detection"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _image != null
                    ? CustomPaint(
                  painter: DetectionPainter(
                    imageFile: _image!,
                    detections: objDetect,
                  ),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
                    : const Center(child: Text("No Image Selected")),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Take Photo"),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Pick Gallery"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: runObjectDetection,
              icon: const Icon(Icons.search),
              label: const Text("Detect Disease"),
            ),
            const SizedBox(height: 20),
            for (var detection in objDetect)
              Text(
                "Detected Class: ${detection?.className}, Confidence: ${detection?.score}",
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        objDetect = [];
      });
    }
  }
}

class DetectionPainter extends CustomPainter {
  final File imageFile;
  final List<ResultObjectDetection?> detections;

  DetectionPainter({required this.imageFile, required this.detections});

  @override
  void paint(Canvas canvas, Size size) {
    final image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        final scale = size.width / info.image.width.toDouble();
        for (var detection in detections) {
          if (detection == null) continue;
          final rect = Rect.fromLTRB(
            detection.rect.left * scale,
            detection.rect.top * scale,
            detection.rect.right * scale,
            detection.rect.bottom * scale,
          );
          final paint = Paint()
            ..color = Colors.red
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2;
          canvas.drawRect(rect, paint);
          final textPainter = TextPainter(
            text: TextSpan(
              text: detection.className,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(minWidth: 0, maxWidth: size.width);
          textPainter.paint(canvas, rect.topLeft);
        }
      }),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ResultObjectDetection {
  final double score;
  final String className;
  final int classIndex;
  final Rect rect;

  ResultObjectDetection({
    required this.score,
    required this.className,
    required this.classIndex,
    required this.rect,
  });

  factory ResultObjectDetection.fromMap(Map<String, dynamic> map) {
    return ResultObjectDetection(
      score: map['score'],
      className: map['className'],
      classIndex: map['classIndex'],
      rect: Rect.fromLTRB(
        map['rect']['left'],
        map['rect']['top'],
        map['rect']['right'],
        map['rect']['bottom'],
      ),
    );
  }
}
