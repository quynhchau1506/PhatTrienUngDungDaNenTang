import 'package:flutter/material.dart';
import 'package:lab6/components/answer_button.dart';
import 'package:lab6/data/question.dart';
import 'package:google_fonts/google_fonts.dart';


class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }




  @override
  Widget build(BuildContext context) {
    final curentQuestion = questions[currentQuestionIndex];


    return  Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch ,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              textAlign: TextAlign.center,
              curentQuestion.text,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,

              ),
              ),
              
            const SizedBox(height: 30,),
            ...curentQuestion.getShuffledAnswer().map((answer) {
              return AnswerButton(
                text: answer,
                 onTap: () {
                  answerQuestion(answer);
                 },
                 );
            }
            )
              
          ],
          
        ),
      )
      );
  }
}