import 'package:flutter/material.dart';
import 'package:lab4/components/gradient_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 232, 154, 180),
          Color.fromARGB(255, 159, 197, 229),
        ),

      ),
    );
    
  }
}



