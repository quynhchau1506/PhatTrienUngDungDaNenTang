import 'package:flutter/material.dart';

class VCard extends StatelessWidget {
  const VCard({super.key, required this.color, required this.child, this.onPress});

  final Color color;
  final Widget child;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: child,
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
