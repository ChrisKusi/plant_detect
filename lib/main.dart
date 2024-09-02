import 'package:flutter/material.dart';
import 'package:plant_detect/splashScreen.dart'; // Import your splash screen widget
import 'package:plant_detect/home.dart';
import 'package:plant_detect/notify.dart'; // Import the notify widget

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
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFe0f2f1), // Light green background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF004d40), // Deeper green for AppBar
          foregroundColor: Colors.white, // White text for AppBar
        ),
      ),
      initialRoute: '/', // Set splash screen as initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(), // Use HomeScreen with bottom navigation
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Notify(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Detect',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notify',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF004d40), // Deeper green for BottomNavigationBar
        onTap: _onItemTapped,
      ),
    );
  }
}
