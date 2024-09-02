// import 'package:flutter/material.dart';
//
// class Learn extends StatelessWidget {
//   // Categorized data structure
//   final Map<String, List<Map<String, String>>> cropCategories = {
//     'Fruits': [
//       {'name': 'Apple', 'image': 'assets/images/apple.jpg'},
//       {'name': 'Blueberry', 'image': 'assets/images/blueberry.jpg'},
//       {'name': 'Cherry', 'image': 'assets/images/cherry.jpg'},
//       {'name': 'Grape', 'image': 'assets/images/grape.jpg'},
//       {'name': 'Peach', 'image': 'assets/images/peach.jpg'},
//       {'name': 'Strawberry', 'image': 'assets/images/strawberry.jpg'},
//     ],
//     'Vegetables': [
//       {'name': 'Bell Pepper', 'image': 'assets/images/bell_pepper.jpg'},
//       {'name': 'Corn', 'image': 'assets/images/corn.jpg'},
//       {'name': 'Potato', 'image': 'assets/images/potato.jpg'},
//       {'name': 'Soybean', 'image': 'assets/images/soybean.jpg'},
//       {'name': 'Squash', 'image': 'assets/images/squash.jpg'},
//       {'name': 'Tomato', 'image': 'assets/images/tomato.jpg'},
//     ],
//     'Herbs': [
//       // This section can be updated when specific herbs are detected
//       {'name': 'Basil', 'image': 'assets/images/basil.jpg'},
//       // Add more herbs or placeholders here
//     ],
//   };
//
//   Learn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Learn About Crops'),
//         backgroundColor: const Color(0xFF004d40), // Brand color
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 50), // Add bottom padding
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Nutrition Chart Section
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Nutrition Chart',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     child: Image(
//                       image: AssetImage('assets/images/nutrition_chart.jpg'),
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Tap on a food tile to see more',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             // Display categories
//             ...cropCategories.entries.map((entry) => _buildCategorySection(entry, context)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategorySection(MapEntry<String, List<Map<String, String>>> category, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 category.key,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Handle "View more" functionality
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ViewMoreScreen(category: category),
//                     ),
//                   );
//                 },
//                 child: const Text('View more', style: TextStyle(color: Color(0xFF004d40))),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 150, // Height of the card row
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: category.value.length,
//               itemBuilder: (context, index) {
//                 final crop = category.value[index];
//                 return _buildCropCard(crop);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCropCard(Map<String, String> crop) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10),
//       width: 120,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 crop['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               crop['name']!,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Example View More Screen
// class ViewMoreScreen extends StatelessWidget {
//   final MapEntry<String, List<Map<String, String>>> category;
//
//   const ViewMoreScreen({required this.category, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.key),
//         backgroundColor: const Color(0xFF004d40),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 3 / 4,
//         ),
//         itemCount: category.value.length,
//         itemBuilder: (context, index) {
//           final crop = category.value[index];
//           return _buildCropCard(crop);
//         },
//       ),
//     );
//   }
//
//   Widget _buildCropCard(Map<String, String> crop) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 crop['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               crop['name']!,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'crop_detail.dart'; // Import the CropDetail screen
//
// class Learn extends StatelessWidget {
//   // Categorized data structure
//   final Map<String, List<Map<String, String>>> cropCategories = {
//     'Fruits': [
//       {'name': 'Apple', 'image': 'assets/images/apple.jpg'},
//       {'name': 'Blueberry', 'image': 'assets/images/blueberry.jpg'},
//       {'name': 'Cherry', 'image': 'assets/images/cherry.jpg'},
//       {'name': 'Grape', 'image': 'assets/images/grape.jpg'},
//       {'name': 'Peach', 'image': 'assets/images/peach.jpg'},
//       {'name': 'Strawberry', 'image': 'assets/images/strawberry.jpg'},
//     ],
//     'Vegetables': [
//       {'name': 'Bell Pepper', 'image': 'assets/images/bell_pepper.jpg'},
//       {'name': 'Corn', 'image': 'assets/images/corn.jpg'},
//       {'name': 'Potato', 'image': 'assets/images/potato.jpg'},
//       {'name': 'Soybean', 'image': 'assets/images/soybean.jpg'},
//       {'name': 'Squash', 'image': 'assets/images/squash.jpg'},
//       {'name': 'Tomato', 'image': 'assets/images/tomato.jpg'},
//     ],
//     'Herbs': [
//       {'name': 'Basil', 'image': 'assets/images/basil.jpg'},
//       // Add more herbs or placeholders here
//     ],
//   };
//
//   Learn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Learn About Crops'),
//         backgroundColor: const Color(0xFF004d40), // Brand color
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 50), // Add bottom padding
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Nutrition Chart Section
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Nutrition Chart',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     child: Image(
//                       image: AssetImage('assets/images/nutrition_chart.jpg'),
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Tap on a food tile to see more',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             // Display categories
//             ...cropCategories.entries.map((entry) => _buildCategorySection(entry, context)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategorySection(MapEntry<String, List<Map<String, String>>> category, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 category.key,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Handle "View more" functionality
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ViewMoreScreen(category: category),
//                     ),
//                   );
//                 },
//                 child: const Text('View more', style: TextStyle(color: Color(0xFF004d40))),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 150, // Height of the card row
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: category.value.length,
//               itemBuilder: (context, index) {
//                 final crop = category.value[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CropDetail(
//                           cropName: crop['name']!,
//                           cropImage: crop['image']!,
//                           description: 'This is a sample description of the crop.', // Replace with actual data
//                           nutritionalValue: 'Sample nutritional information.', // Replace with actual data
//                           diseases: [
//                             // Sample data, replace with actual data
//                             {
//                               'name': 'Sample Disease',
//                               'cause': 'Sample cause',
//                               'effect': 'Sample effect',
//                               'solution': 'Sample solution',
//                               'bestPractice': 'Sample best practice',
//                             },
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   child: _buildCropCard(crop),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCropCard(Map<String, String> crop) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10),
//       width: 120,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 crop['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               crop['name']!,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Example View More Screen
// class ViewMoreScreen extends StatelessWidget {
//   final MapEntry<String, List<Map<String, String>>> category;
//
//   const ViewMoreScreen({required this.category, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category.key),
//         backgroundColor: const Color(0xFF004d40),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 3 / 4,
//         ),
//         itemCount: category.value.length,
//         itemBuilder: (context, index) {
//           final crop = category.value[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CropDetail(
//                     cropName: crop['name']!,
//                     cropImage: crop['image']!,
//                     description: 'This is a sample description of the crop.', // Replace with actual data
//                     nutritionalValue: 'Sample nutritional information.', // Replace with actual data
//                     diseases: [
//                       // Sample data, replace with actual data
//                       {
//                         'name': 'Sample Disease',
//                         'cause': 'Sample cause',
//                         'effect': 'Sample effect',
//                         'solution': 'Sample solution',
//                         'bestPractice': 'Sample best practice',
//                       },
//                     ],
//                   ),
//                 ),
//               );
//             },
//             child: _buildCropCard(crop),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildCropCard(Map<String, String> crop) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               child: Image.asset(
//                 crop['image']!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               crop['name']!,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'crop_detail.dart'; // Import the CropDetail screen

class Learn extends StatelessWidget {
  // Categorized data structure with full crop details
  final Map<String, List<Map<String, dynamic>>> cropCategories = {
    'Fruits': [
      {
        'name': 'Apple',
        'image': 'assets/images/apple.jpg',
        'description': 'Apples are round fruits with crisp, juicy flesh. They come in various colors like red, green, and yellow and are consumed fresh or used in cooking.',
        'nutritionalValue': 'Calories: 95, Carbohydrates: 25g, Fiber: 4g, Vitamins: C, Potassium.',
        'diseases': [
          {
            'name': 'Apple Scab Leaf',
            'cause': 'Fungus Venturia inaequalis',
            'effect': 'Causes dark, scabby lesions on leaves and fruit.',
            'solution': 'Apply fungicides and practice orchard sanitation.',
            'bestPractice': 'Regular pruning and removing infected leaves to reduce spread.'
          },
          {
            'name': 'Apple Rust Leaf',
            'cause': 'Fungus Gymnosporangium spp.',
            'effect': 'Causes orange or rust-colored spots on leaves.',
            'solution': 'Apply sulfur or other fungicides to affected areas.',
            'bestPractice': 'Avoid planting near junipers, which are alternate hosts for rust.'
          },
        ]
      },
      {
        'name': 'Blueberry',
        'image': 'assets/images/blueberry.jpg',
        'description': 'Blueberries are small, round, and blue-purple fruits with a sweet and slightly tart flavor. They are rich in antioxidants and vitamins.',
        'nutritionalValue': 'Calories: 85 per cup, Carbohydrates: 21g, Fiber: 4g, Vitamins: C, K.',
        'diseases': [
          {
            'name': 'Blueberry Leaf Spot',
            'cause': 'Fungus Septoria albopunctata',
            'effect': 'Causes small, circular spots on leaves.',
            'solution': 'Apply fungicides and ensure proper spacing for air circulation.',
            'bestPractice': 'Prune and remove infected leaves to reduce spread.'
          },
        ]
      },
      {
        'name': 'Cherry',
        'image': 'assets/images/cherry.jpg',
        'description': 'Cherries are small, round, and red or black fruits with a sweet or tart flavor. They are often eaten fresh or used in desserts.',
        'nutritionalValue': 'Calories: 50 per 100g, Carbohydrates: 12g, Fiber: 1.6g, Vitamins: C, A.',
        'diseases': [
          {
            'name': 'Cherry Leaf Spot',
            'cause': 'Fungus Blumeriella jaapii',
            'effect': 'Small, purple spots on leaves that turn brown and drop prematurely.',
            'solution': 'Apply fungicides and remove infected leaves.',
            'bestPractice': 'Ensure good air circulation and avoid overhead irrigation.'
          },
        ]
      },
      {
        'name': 'Grape',
        'image': 'assets/images/grape.jpg',
        'description': 'Grapes are small, round fruits that grow in clusters. They come in various colors, including green, red, and black, and are used in wine-making, eaten fresh, or dried as raisins.',
        'nutritionalValue': 'Calories: 62 per cup, Carbohydrates: 16g, Fiber: 1g, Vitamins: C, K.',
        'diseases': [
          {
            'name': 'Grape Black Rot',
            'cause': 'Fungus Guignardia bidwellii',
            'effect': 'Causes black, sunken lesions on leaves and fruit.',
            'solution': 'Use fungicides and remove infected leaves.',
            'bestPractice': 'Ensure proper pruning and air circulation.'
          },
        ]
      },
      {
        'name': 'Peach',
        'image': 'assets/images/peach.jpg',
        'description': 'Peaches are round fruits with fuzzy skin and sweet, juicy flesh. They are typically yellow or white and enjoyed fresh, canned, or in desserts.',
        'nutritionalValue': 'Calories: 59 per medium fruit, Carbohydrates: 14g, Fiber: 2g, Vitamins: C, A.',
        'diseases': [
          {
            'name': 'Peach Leaf Curl',
            'cause': 'Fungus Taphrina deformans',
            'effect': 'Causes leaves to curl, thicken, and change color.',
            'solution': 'Apply fungicides during dormancy.',
            'bestPractice': 'Ensure proper pruning and sanitation.'
          },
        ]
      },
      {
        'name': 'Strawberry',
        'image': 'assets/images/strawberry.jpg',
        'description': 'Strawberries are red, heart-shaped fruits with a juicy texture and sweet flavor. They are often eaten fresh or used in desserts.',
        'nutritionalValue': 'Calories: 32 per cup, Carbohydrates: 7.7g, Fiber: 2g, Vitamins: C, Manganese.',
        'diseases': [
          {
            'name': 'Strawberry Leaf Spot',
            'cause': 'Fungus Mycosphaerella fragariae',
            'effect': 'Small, dark spots on leaves that can merge and cause defoliation.',
            'solution': 'Apply fungicides and practice good field sanitation.',
            'bestPractice': 'Ensure proper spacing and remove infected leaves.'
          },
        ]
      },
    ],
    'Vegetables': [
      {
        'name': 'Bell Pepper',
        'image': 'assets/images/bell_pepper.jpg',
        'description': 'Bell peppers are sweet, crisp vegetables available in green, red, yellow, and orange. They are used in salads, stir-fries, and various dishes.',
        'nutritionalValue': 'Calories: 30, Carbohydrates: 7g, Fiber: 2.5g, Vitamins: C, A, B6.',
        'diseases': [
          {
            'name': 'Bell Pepper Leaf Spot',
            'cause': 'Fungus Cercospora capsici',
            'effect': 'Spots on leaves leading to defoliation.',
            'solution': 'Use copper fungicides.',
            'bestPractice': 'Rotate crops and avoid overhead watering.'
          },
        ]
      },
      {
        'name': 'Corn',
        'image': 'assets/images/corn.jpg',
        'description': 'Corn is a tall cereal plant that produces large ears with rows of yellow kernels. It is a staple food in many cultures and is used in various forms like cornmeal, corn syrup, and popcorn.',
        'nutritionalValue': 'Calories: 96 per 100g, Carbohydrates: 21g, Fiber: 2.4g, Vitamins: B6, Magnesium.',
        'diseases': [
          {
            'name': 'Corn Leaf Blight',
            'cause': 'Fungus Exserohilum turcicum',
            'effect': 'Grayish-green, elongated spots on leaves.',
            'solution': 'Use fungicides and resistant hybrids.',
            'bestPractice': 'Practice crop rotation and residue management.'
          },
          {
            'name': 'Corn Rust Leaf',
            'cause': 'Fungus Puccinia sorghi',
            'effect': 'Reddish-brown pustules on leaves.',
            'solution': 'Apply fungicides when rust is detected.',
            'bestPractice': 'Use resistant hybrids and rotate crops.'
          },
        ]
      },
      {
        'name': 'Potato',
        'image': 'assets/images/potato.jpg',
        'description': 'Potatoes are starchy tubers with brown skin and white or yellow flesh. They are used in a variety of dishes, including mashed potatoes, fries, and chips.',
        'nutritionalValue': 'Calories: 77 per 100g, Carbohydrates: 17g, Fiber: 2.2g, Vitamins: C, B6, Potassium.',
        'diseases': [
          {
            'name': 'Potato Early Blight',
            'cause': 'Fungus Alternaria solani',
            'effect': 'Dark, concentric spots on leaves leading to defoliation.',
            'solution': 'Apply fungicides and practice crop rotation.',
            'bestPractice': 'Remove infected plant debris and use resistant varieties.'
          },
          {
            'name': 'Potato Late Blight',
            'cause': 'Fungus Phytophthora infestans',
            'effect': 'Water-soaked lesions on leaves and stems.',
            'solution': 'Use fungicides and resistant varieties.',
            'bestPractice': 'Practice crop rotation and proper plant spacing.'
          },
        ]
      },
      {
        'name': 'Soybean',
        'image': 'assets/images/soybean.jpg',
        'description': 'Soybeans are legumes known for their high protein content. They are used in various forms, including soy milk, tofu, and edamame.',
        'nutritionalValue': 'Calories: 173 per cup, Carbohydrates: 9.9g, Fiber: 6g, Protein: 16g, Vitamins: K, B6, Folate.',
        'diseases': [
          {
            'name': 'Soybean Leaf Spot',
            'cause': 'Fungus Cercospora sojina',
            'effect': 'Small, angular spots on leaves that can merge and cause defoliation.',
            'solution': 'Apply fungicides and practice crop rotation.',
            'bestPractice': 'Use resistant varieties and manage plant density.'
          },
        ]
      },
      {
        'name': 'Squash',
        'image': 'assets/images/squash.jpg',
        'description': 'Squash are vegetables that come in a variety of shapes and colors, including yellow, green, and orange. They are used in soups, salads, and as a cooked side dish.',
        'nutritionalValue': 'Calories: 16 per 100g, Carbohydrates: 3.3g, Fiber: 1.1g, Vitamins: A, C, B6.',
        'diseases': [
          {
            'name': 'Powdery Mildew',
            'cause': 'Fungus Erysiphe cichoracearum',
            'effect': 'White, powdery spots on leaves.',
            'solution': 'Use fungicides and remove infected leaves.',
            'bestPractice': 'Ensure good air circulation and avoid overhead irrigation.'
          },
        ]
      },
      {
        'name': 'Tomato',
        'image': 'assets/images/tomato.jpg',
        'description': 'Tomatoes are juicy, red fruits commonly used in salads, sauces, and cooking. They are rich in vitamins and antioxidants.',
        'nutritionalValue': 'Calories: 18 per 100g, Carbohydrates: 3.9g, Fiber: 1.2g, Vitamins: C, K, Folate.',
        'diseases': [
          {
            'name': 'Tomato Early Blight',
            'cause': 'Fungus Alternaria solani',
            'effect': 'Dark spots on leaves that can cause defoliation.',
            'solution': 'Use fungicides and resistant varieties.',
            'bestPractice': 'Practice crop rotation and remove infected plant debris.'
          },
          {
            'name': 'Tomato Leaf Spot',
            'cause': 'Bacterium Xanthomonas vesicatoria',
            'effect': 'Small, water-soaked spots that can cause leaves to drop.',
            'solution': 'Use copper-based bactericides.',
            'bestPractice': 'Avoid working with wet plants and rotate crops.'
          },
        ]
      },
    ],
    'Herbs': [
      {
        'name': 'Basil',
        'image': 'assets/images/basil.jpg',
        'description': 'Basil is a fragrant herb commonly used in cooking. It has soft, bright green leaves and a distinct aroma.',
        'nutritionalValue': 'Calories: 5 per 1/4 cup, Vitamins: A, K, Calcium, Iron.',
        'diseases': [
          {
            'name': 'Downy Mildew',
            'cause': 'Fungus Peronospora belbahrii',
            'effect': 'Yellowing and browning of leaves.',
            'solution': 'Ensure good air circulation and avoid wetting the foliage.',
            'bestPractice': 'Water the soil, not the leaves, and use resistant varieties.'
          },
        ]
      },
    ],
  };


  Learn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn About Crops'),
        backgroundColor: const Color(0xFF004d40), // Brand color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 50), // Add bottom padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nutrition Chart Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutrition Chart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      image: AssetImage('assets/images/nutrition_chart.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tap on a food tile to see more',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Display categories
            ...cropCategories.entries.map((entry) => _buildCategorySection(entry, context)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(MapEntry<String, List<Map<String, dynamic>>> category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.key,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Handle "View more" functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewMoreScreen(category: category),
                    ),
                  );
                },
                child: const Text('View more', style: TextStyle(color: Color(0xFF004d40))),
              ),
            ],
          ),
          SizedBox(
            height: 150, // Height of the card row
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.value.length,
              itemBuilder: (context, index) {
                final crop = category.value[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CropDetail(
                          cropName: crop['name'],
                          cropImage: crop['image'],
                          description: crop['description'],
                          nutritionalValue: crop['nutritionalValue'],
                          diseases: List<Map<String, String>>.from(crop['diseases']),
                        ),
                      ),
                    );
                  },
                  child: _buildCropCard(crop),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> crop) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                crop['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              crop['name']!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Example View More Screen
class ViewMoreScreen extends StatelessWidget {
  final MapEntry<String, List<Map<String, dynamic>>> category;

  const ViewMoreScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.key),
        backgroundColor: const Color(0xFF004d40),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 4,
        ),
        itemCount: category.value.length,
        itemBuilder: (context, index) {
          final crop = category.value[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CropDetail(
                    cropName: crop['name'],
                    cropImage: crop['image'],
                    description: crop['description'],
                    nutritionalValue: crop['nutritionalValue'],
                    diseases: List<Map<String, String>>.from(crop['diseases']),
                  ),
                ),
              );
            },
            child: _buildCropCard(crop),
          );
        },
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> crop) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                crop['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              crop['name']!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

