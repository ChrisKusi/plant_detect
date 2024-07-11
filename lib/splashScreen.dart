import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showAppName = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Show app name after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showAppName = true;
      });

      // Navigate to home screen after another 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home'); // Replace '/home' with your actual route
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adjust the size of the Lottie animation
              SizedBox(
                height: 300, // Adjust the height as needed
                child: Lottie.asset(
                  'assets/animations/splash.json', // Replace with your Lottie file path
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
              const SizedBox(height: 20), // Add some space below the animation
              // Display app name with a fade-in animation
              AnimatedOpacity(
                opacity: showAppName ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Leaf Scan', // Replace with your app name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Customize text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
