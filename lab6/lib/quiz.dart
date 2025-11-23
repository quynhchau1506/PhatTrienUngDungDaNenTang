import 'package:flutter/material.dart';
import 'package:lab6/data/question.dart';
import 'package:lab6/screens/questions_screen.dart';
import 'package:lab6/screens/results_screen.dart';
import 'package:lab6/screens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';
  void switchScreen(){
    setState(() {
      activeScreen = 'question-screen';
    });
  }
  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }



  @override
  Widget build(BuildContext context) {

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen'){
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    //final screenWidget = activeScreen == 'start-screen'
    //? StartScreen(switchScreen) 
    //: const QuestionsScreen();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Color.fromARGB(255, 223, 212, 233),
              Color.fromARGB(255, 232, 196, 223),
              ],
              )
          ),
           child: screenWidget,
        ),
      ),
    );
  }
}