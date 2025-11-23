import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoll extends StatefulWidget {
  const DiceRoll({super.key});

  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceRoll> {
  var currentDice = 1;

  void rollDice() {
    setState(() {
      currentDice = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.asset(
              'assets/images/dice-$currentDice.png',
               width: 200,
            ),
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 28,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: rollDice, 
              child: const Text('Roll Dice')
              ),
            ],
            );
  }
}