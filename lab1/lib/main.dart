import 'package:flutter/material.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          title: const Text('I Am Rich'),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: Icon(Icons.arrow_back_ios),
        ),
        body: Center(
          child: Image(
          image: AssetImage('assest/images/rich.webp')

        ),
        )
   
      )));
}
