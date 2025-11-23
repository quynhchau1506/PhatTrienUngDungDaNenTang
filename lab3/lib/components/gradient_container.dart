import 'package:flutter/material.dart';
import 'package:lab3/components/dice_roller.dart';

const startAligment = Alignment.topLeft;
const endAligment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: startAligment,
              end:  endAligment,
              colors: [color1, color2], 
              )
          ),
          child: Center(
            child: DiceRoll(),
    ),
        );
  }
}