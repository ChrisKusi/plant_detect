
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<ResultObjectDetection> objDetect = [];
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> runObjectDetection() async {
//     if (_image == null) {
//       print('No image selected');
//       return;
//     }

//     final bytes = await _image!.readAsBytes();

//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     try {
//       // Use your host machine's IP address
//       final uri = Uri.parse('http://192.168.0.140:5000/detect');
//       final request = http.MultipartRequest('POST', uri);
//       request.files.add(
//         http.MultipartFile.fromBytes(
//           'image',
//           bytes,
//           filename: 'image.png',
//         ),
//       );

//       // Set timeout for the request
//       final response = await request.send().timeout(const Duration(seconds: 30));
//       final responseData = await http.Response.fromStream(response);

//       if (responseData.statusCode != 200) {
//         throw Exception('Failed to detect disease: ${responseData.statusCode} - ${responseData.reasonPhrase}');
//       }

//       final Map<String, dynamic> responseJson = json.decode(responseData.body);

//       // Display the detections
//       setState(() {
//         objDetect = (responseJson['detections'] as List)
//             .map<ResultObjectDetection>((item) => ResultObjectDetection.fromMap(Map<String, dynamic>.from(item)))
//             .toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error during object detection: $e');
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Failed to detect disease: $e';
//       });
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text('Failed to detect disease: $e'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Plant Disease Detection"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 height: 300,
//                 width: 300,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: _image != null
//                       ? Image.file(
//                           _image!,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: double.infinity,
//                         )
//                       : const Center(child: Text("No Image Selected")),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Take Photo"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo_library),
//                     label: const Text("Pick Gallery"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               if (isLoading) const CircularProgressIndicator(),
//               if (!isLoading)
//                 ElevatedButton.icon(
//                   onPressed: runObjectDetection,
//                   icon: const Icon(Icons.search),
//                   label: const Text("Detect Disease"),
//                 ),
//               const SizedBox(height: 20),
//               if (errorMessage.isNotEmpty)
//                 Text(
//                   errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               for (var detection in objDetect)
//                 Card(
//                   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                   child: ListTile(
//                     leading: const Icon(Icons.bug_report, color: Colors.red),
//                     title: Text("Disease: ${detection.className}"),
//                     subtitle: Text("Confidence: ${(detection.confidence * 100).toStringAsFixed(2)}%"),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedImage = await _picker.pickImage(source: source);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//         objDetect = [];
//       });
//     }
//   }
// }

// class ResultObjectDetection {
//   final String className;
//   final double confidence;

//   ResultObjectDetection({required this.className, required this.confidence});

//   factory ResultObjectDetection.fromMap(Map<String, dynamic> map) {
//     return ResultObjectDetection(
//       className: map['class_name'],
//       confidence: map['confidence'],
//     );
//   }
// }


//with solutions

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ResultObjectDetection> objDetect = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String errorMessage = '';

  // Add a map to store solutions and best practices for each disease
  final Map<String, Map<String, String>> diseaseSolutions = {
    'Apple Scab Leaf': {
      'solution': 'Apply fungicides and practice good orchard sanitation.',
      'best_practice': 'Remove and destroy infected leaves and fruit to reduce the spread of the disease.',
    },
    'Apple leaf': {
      'solution': 'Ensure proper fertilization and watering.',
      'best_practice': 'Prune trees to improve air circulation and reduce humidity.',
    },
    'Apple rust leaf': {
      'solution': 'Apply sulfur or other fungicides to affected areas.',
      'best_practice': 'Avoid planting near junipers, which are alternate hosts for rust.',
    },
    'Bell_pepper leaf spot': {
      'solution': 'Use copper-based fungicides to manage the disease.',
      'best_practice': 'Rotate crops and avoid overhead watering to reduce spread.',
    },
    'Bell_pepper leaf': {
      'solution': 'Ensure proper watering and nutrient management.',
      'best_practice': 'Maintain healthy plants through regular care and monitoring.',
    },
    'Blueberry leaf': {
      'solution': 'Apply appropriate fungicides if needed.',
      'best_practice': 'Ensure proper spacing and pruning to improve air circulation.',
    },
    'Cherry leaf': {
      'solution': 'Use fungicides and remove infected leaves.',
      'best_practice': 'Avoid overhead irrigation and ensure good air circulation.',
    },
    'Corn Gray leaf spot': {
      'solution': 'Apply fungicides and use resistant hybrids.',
      'best_practice': 'Rotate crops and remove infected plant debris.',
    },
    'Corn leaf blight': {
      'solution': 'Use fungicides and resistant hybrids.',
      'best_practice': 'Practice crop rotation and residue management.',
    },
    'Corn rust leaf': {
      'solution': 'Apply fungicides when rust is detected.',
      'best_practice': 'Use resistant hybrids and rotate crops.',
    },
    'Peach leaf': {
      'solution': 'Apply fungicides during dormancy.',
      'best_practice': 'Ensure proper pruning and sanitation.',
    },
    'Potato leaf early blight': {
      'solution': 'Apply fungicides and practice crop rotation.',
      'best_practice': 'Remove infected plant debris and use resistant varieties.',
    },
    'Potato leaf late blight': {
      'solution': 'Use fungicides and resistant varieties.',
      'best_practice': 'Practice crop rotation and proper plant spacing.',
    },
    'Potato leaf': {
      'solution': 'Ensure proper nutrient management and watering.',
      'best_practice': 'Monitor plants regularly for signs of disease.',
    },
    'Raspberry leaf': {
      'solution': 'Apply fungicides and remove infected leaves.',
      'best_practice': 'Ensure good air circulation and avoid overhead irrigation.',
    },
    'Soyabean leaf': {
      'solution': 'Use fungicides and resistant varieties.',
      'best_practice': 'Rotate crops and manage plant density.',
    },
    'Soybean leaf': {
      'solution': 'Apply appropriate fungicides if needed.',
      'best_practice': 'Practice crop rotation and good field sanitation.',
    },
    'Squash Powdery mildew leaf': {
      'solution': 'Use fungicides and remove infected leaves.',
      'best_practice': 'Ensure good air circulation and avoid overhead irrigation.',
    },
    'Strawberry leaf': {
      'solution': 'Apply fungicides and practice good field sanitation.',
      'best_practice': 'Ensure proper spacing and remove infected leaves.',
    },
    'Tomato Early blight leaf': {
      'solution': 'Use fungicides and resistant varieties.',
      'best_practice': 'Practice crop rotation and remove infected plant debris.',
    },
    'Tomato Septoria leaf spot': {
      'solution': 'Apply fungicides and remove infected leaves.',
      'best_practice': 'Ensure proper plant spacing and avoid overhead watering.',
    },
    'Tomato leaf bacterial spot': {
      'solution': 'Use copper-based bactericides.',
      'best_practice': 'Avoid working with wet plants and rotate crops.',
    },
    'Tomato leaf late blight': {
      'solution': 'Apply fungicides and use resistant varieties.',
      'best_practice': 'Practice crop rotation and remove infected plant debris.',
    },
    'Tomato leaf mosaic virus': {
      'solution': 'Remove and destroy infected plants.',
      'best_practice': 'Practice good field sanitation and use virus-free seeds.',
    },
    'Tomato leaf yellow virus': {
      'solution': 'Remove infected plants and control whiteflies.',
      'best_practice': 'Use reflective mulches to deter whiteflies.',
    },
    'Tomato leaf': {
      'solution': 'Ensure proper watering and nutrient management.',
      'best_practice': 'Monitor plants regularly for signs of disease.',
    },
    'Tomato mold leaf': {
      'solution': 'Apply fungicides and remove infected leaves.',
      'best_practice': 'Ensure good air circulation and avoid overhead irrigation.',
    },
    'Tomato two spotted spider mites leaf': {
      'solution': 'Use miticides and remove infested leaves.',
      'best_practice': 'Ensure proper watering and avoid plant stress.',
    },
    'grape leaf black rot': {
      'solution': 'Use fungicides and remove infected leaves.',
      'best_practice': 'Ensure proper pruning and air circulation.',
    },
    'grape leaf': {
      'solution': 'Apply appropriate fungicides if needed.',
      'best_practice': 'Monitor plants regularly and ensure good air circulation.',
    },
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> runObjectDetection() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    final bytes = await _image!.readAsBytes();

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final uri = Uri.parse('https://plant-disease-backend-epc9.onrender.com/detect');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'image.png',
        ),
      );

      final response = await request.send().timeout(const Duration(seconds: 60));
      final responseData = await http.Response.fromStream(response);

      if (responseData.statusCode != 200) {
        throw Exception('Failed to detect disease: ${responseData.statusCode} - ${responseData.reasonPhrase}');
      }

      final Map<String, dynamic> responseJson = json.decode(responseData.body);

      setState(() {
        objDetect = (responseJson['detections'] as List)
            .map<ResultObjectDetection>((item) => ResultObjectDetection.fromMap(Map<String, dynamic>.from(item)))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error during object detection: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to detect disease: $e';
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to detect disease: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Disease Detection"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
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
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                      iconColor: Colors.white,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Pick Gallery"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                      iconColor: Colors.white,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                ElevatedButton.icon(
                  onPressed: runObjectDetection,
                  icon: const Icon(Icons.search),
                  label: const Text("Detect Disease"),
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    iconColor: Colors.white,
                    foregroundColor: Colors.white,
                    
                    
                  ),
                ),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              for (var detection in objDetect)
                Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Condition: ${detection.className}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Confidence: ${(detection.confidence * 100).toStringAsFixed(2)}%",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        if (diseaseSolutions.containsKey(detection.className))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Solution: ${diseaseSolutions[detection.className]!['solution']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Best Practice: ${diseaseSolutions[detection.className]!['best_practice']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
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

class ResultObjectDetection {
  final String className;
  final double confidence;

  ResultObjectDetection({required this.className, required this.confidence});

  factory ResultObjectDetection.fromMap(Map<String, dynamic> map) {
    return ResultObjectDetection(
      className: map['class_name'],
      confidence: map['confidence'],
    );
  }
}



