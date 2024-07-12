import 'package:flutter/material.dart';
import 'package:plant_detect/splashScreen.dart'; // Import your splash screen widget
import 'package:plant_detect/home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line to remove the debug banner
      title: 'Plant Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set splash screen as initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const Home(), // Replace with your actual home screen route

      },
    );
  }
}