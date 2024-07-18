import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notify'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Notification Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
