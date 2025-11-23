import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/quiz_ava.png',
          width: 300,),
          const SizedBox(height: 80,),
         const Text('Quiz',
         style: TextStyle(
          fontSize: 24,
          color: Colors.white,
         ),
         ),
          const SizedBox(height: 30,),
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_right_alt),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: widget.startQuiz,
           label: const Text("Start"),)
        ],
      ),
    );
  }
}