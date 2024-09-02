// import 'package:flutter/material.dart';
// import 'package:plant_detect/splashScreen.dart'; // Import your splash screen widget
// import 'package:plant_detect/home.dart';
// import 'package:plant_detect/notify.dart'; // Import the notify widget
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Add this line to remove the debug banner
//       title: 'Plant Disease Detection',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         scaffoldBackgroundColor: const Color(0xFFe0f2f1), // Light green background
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF004d40), // Deeper green for AppBar
//           foregroundColor: Colors.white, // White text for AppBar
//         ),
//       ),
//       initialRoute: '/', // Set splash screen as initial route
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/home': (context) => const HomeScreen(), // Use HomeScreen with bottom navigation
//       },
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Home(),
//     Notify(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Detect',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notify',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white54,
//         backgroundColor: const Color(0xFF004d40), // Deeper green for BottomNavigationBar
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plant_detect/home.dart'; // Import your Home widget
import 'package:plant_detect/learn.dart'; // Import your Learn widget
import 'package:plant_detect/notify.dart'; // Import your Notify widget

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFe0f2f1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF004d40),
          foregroundColor: Colors.white,
        ),
      ),
      home: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 1; // Default to the Home screen (Detect) item
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _screens = [
    Learn(),  // Learn screen
    Home(),   // Home screen with the detection feature
    Notify(), // Notify screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extend the body behind the navigation bar for transparency
      body: _screens[_pageIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 1, // Center item (Home/Detect) is the default selected
            items: <Widget>[
              Icon(Icons.book, size: 30, color: _pageIndex == 0 ? Colors.white : Colors.white),
              Icon(Icons.camera_alt, size: 30, color: _pageIndex == 1 ? Colors.white : Colors.white),
              Icon(Icons.notifications, size: 30, color: _pageIndex == 2 ? Colors.white : Colors.white),
            ],
            color: const Color(0xFF004d40), // Use brand color for the navigation bar
            buttonBackgroundColor: const Color(0xFF004d40), // Use brand color for button background
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: _onItemTapped,
          ),
          Positioned(
            bottom: 10, // Adjust position of labels
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem('Learn', 0),
                SizedBox(width: MediaQuery.of(context).size.width * 0.260),

                _buildNavItem('Scan', 1),
                SizedBox(width: MediaQuery.of(context).size.width * 0.260), // Spacer for the center item
                _buildNavItem('Notify', 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _pageIndex == index ? Colors.white : Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
