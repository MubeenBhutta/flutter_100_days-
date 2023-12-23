import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorx = Colors.black54;

class Policy extends StatefulWidget {
  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  List<String> _questions = [];

  Future<List<String>> _loadQuestions() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/privacy-policy.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        questions.add(i);
      }
    });
    return questions;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> questions = await _loadQuestions();

    // Notify the UI and display the questions
    setState(() {
      _questions = questions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorx,
        title: Text("Privacy Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Text(
                    _questions[index],
                    style: TextStyle(fontSize: 16.0),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
