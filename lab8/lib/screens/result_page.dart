import 'package:flutter/material.dart';
import 'package:flutter_vku_lab8/components/bottom_button.dart';
import 'package:flutter_vku_lab8/components/v_card.dart';
import 'package:flutter_vku_lab8/constant.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
      {super.key,
      required this.bmiResult,
      required this.resultText,
      required this.interpretation});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomLeft,
                  child: Text('Your Result', style: kTitleTextStyle))),
          Expanded(
              flex: 5,
              child: VCard(
                  color: kActiveCardColour,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(resultText.toUpperCase(), style: kResultTextStyle),
                      Text(
                        bmiResult,
                        style: kBMITextStyle,
                      ),
                      Text(
                        interpretation,
                        style: kBodyTextStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))),
          Expanded(
              child: BottomButton(onTap: () {
                Navigator.pop(context);
              }, buttonTitle: 'RE-CALCULATE'))
        ],
      ),
    );
  }
}
