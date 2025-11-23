import 'package:flutter/material.dart';
import 'dart:math';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  var currentDice = 1;

  void magicBall() {
    setState(() {
      currentDice = Random().nextInt(8) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.asset(
              'assets/images/magicball-$currentDice.png',
               
            ),
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 28,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: magicBall, 
              child: const Text('Magic Ball')
              ),
            ],
            );
  }
}