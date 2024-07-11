import 'dart:io';
import 'package:flutter/material.dart';import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
// For CustomPainter

Future<Interpreter> loadModel() async {
  final interpreter = await Interpreter.fromAsset('assets/models/best.tflite');
  return interpreter;
}

img.Image preprocessImage(File imageFile) {
  // 1. Load the image
  img.Image originalImage = img.decodeImage(imageFile.readAsBytesSync())!;

  // 2. Resize the image to 640x640
  img.Image resizedImage = img.copyResize(originalImage, width: 640, height: 640);

  // 3.Perform any other necessary preprocessing (e.g., color conversion)
  // ... (Add any other preprocessing steps here if required by your model)

  return resizedImage;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _image;
  List<Map<String, dynamic>> _detections = []; // Store detected objects
  List<String> classNames = [ // Define classNames here
    "Apple Scab Leaf",
    "Apple leaf",
    "Apple rust leaf",
    "Bell_pepper leaf spot",
    "Bell_pepper leaf",
    "Blueberry leaf",
    "Cherry leaf",
    "Corn Gray leaf spot",
    "Corn leaf blight",
    "Corn rust leaf",
    "Peach leaf", // Add the missing comma
    "Potato leaf early blight",
    "Potato leaf late blight",
    "Potato leaf",
    "Raspberry leaf",
    "Soyabean leaf",
    "Squash Powdery mildew leaf",
    "Strawberry leaf",
    "Tomato Early blight leaf",
    "Tomato Septoria leaf spot",
    "Tomato leaf bacterial spot",
    "Tomato leaf late blight",
    "Tomato leaf mosaic virus",
    "Tomato leaf yellow virus",
    "Tomato leaf",
    "Tomato mold leaf",
    "Tomato two spotted spider mites leaf",
    "grape leaf black rot",
    "grape leaf"
  ];

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _detections = []; // Clear previous detections
      });
    }
  }

  void _detectDisease() async {
    if (_image != null) {
      final interpreter = await loadModel();
      final inputImage = preprocessImage(_image!);

      // Prepare input and output tensors
      var input = List.generate(1, (index) => List.filled(640 * 640 * 3, 0.0)).reshape([1, 640, 640, 3]);
      var output = List.filled(1 * 34 * 8400, 0.0).reshape([1, 34, 8400]);

      // Normalize pixel values
      for (int i = 0; i < inputImage.getBytes().length; i++) {
        input[0][i ~/ (640 * 3)][(i % (640 * 3)) ~/ 3][i % 3] = inputImage.getBytes()[i] / 255.0;
      }

      // Run inference
      interpreter.run(input, output);

      // Process output tensor
      _detections = []; // Clear previous detections
      for (int i = 0; i < 8400; i++) {
        double objectness = output[0][4][i]; // Assuming objectness is at index 4
        if (objectness > 0.2) { // Apply confidence threshold
          List<double> classProbs = output[0].sublist(5).map((v) => v[i]).toList(); // Assuming classes start at index 5
          int detectedClassIndex = classProbs.indexOf(classProbs.reduce((a, b) => a > b ? a : b));
          print("Detected class index: $detectedClassIndex, Class name: ${classNames[detectedClassIndex]}");

          // Extract bounding box coordinates (replace with your logic)
          List<double> boxCoords = [0.0, 0.0, 0.0, 0.0]; // Placeholder
          _detections.add({
            'box': boxCoords,
            'class': detectedClassIndex,
            'confidence': objectness,
          });
        }
      }
      print("Output tensor: $output");
      print("Detections: $_detections");

      // Perform NMS on detections (add your NMS logic here)
      // ...

      // Update UI with results
      setState(() {});

      interpreter.close();
    } else {
      // Show a message to select an image
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Disease Detection"),
        centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Photo Box
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
                    ? CustomPaint( // Use CustomPaint to draw detections
                  //painter: DetectionPainter(detections: _detections, classNames: classNames),
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
            // Buttons
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
              onPressed: _detectDisease,
              icon: const Icon(Icons.search),
              label: const Text("Detect Disease"),
            ),
            const SizedBox(height: 20),
            // Display detection results (adapt to show detected objects)
            // ... (Add your UI logic here to display bounding boxes and labels)
            for (var detection in _detections)
              Text("Detected Class: ${classNames[detection['class']]}, Confidence: ${detection['confidence']}"),
          ],
        ),
      ),
    );
  }
}
