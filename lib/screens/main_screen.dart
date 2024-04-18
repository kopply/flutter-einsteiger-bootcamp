import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
