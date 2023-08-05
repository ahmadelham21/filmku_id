import 'package:flutter/material.dart';

void main() {
  const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            "setan",
            style: TextStyle(
              fontSize: 100,
            ),
          ),
        ),
      ),
    );
  }
}
