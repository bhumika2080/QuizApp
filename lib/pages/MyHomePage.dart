// chatgpt fine tuned some stuff so there's less error message

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_app/QuizScreen.dart';
import '../models/question_model.dart';
import 'ResultPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Trivia> list = [];
  bool isLoaded = false;
  String userName = ''; // Variable to store user's name

  @override
  void initState() {
    // Move data fetching logic to initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    // Use try-catch to handle exceptions
    try {
      list = await ApiCalling().getData();
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      // Handle the exception, e.g., show an error message
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!isKeyboard)
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
              ),
            const SizedBox(height: 20),
            const Text(
              'Enter your name',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: userName.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()),
                      );
                      // ResultPage resultinstance = ResultPage();
                      // resultinstance.setUserName(userName);
                    }
                  : null,
              child: const Text('Start'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: userName.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPage(userName: userName)),
                      );
                    }
                  : null,
              child: const Text('View Quiz Result'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
