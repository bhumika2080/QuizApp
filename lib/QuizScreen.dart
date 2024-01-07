import 'dart:async';
import 'package:flutter/material.dart';
import 'models/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Trivia> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int seconds = 30;
  bool answerClicked = false;
  bool timerRunning = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final apiCalling = ApiCalling();
    questions = (await apiCalling.getData());
    setState(() {});
  }

  void startTimer() {
    timerRunning = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        goToNextQuestion();
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 30;
    });
  }

  void goToNextQuestion() {
    resetTimer();
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        answerClicked = false;
      });
    } else {
      // Handle quiz completion or navigate to result screen
      // You can implement this based on your specific needs
      // For now, let's just reset the quiz
      setState(() {
        currentQuestionIndex = 0;
        correctAnswers = 0;
      });
    }
  }

  void checkAnswer(String selectedOption) {
    if (!answerClicked) {
      answerClicked = true;
      timerRunning = false;
      if (selectedOption == questions[currentQuestionIndex].correctAnswer) {
        setState(() {
          correctAnswers++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle previous button click
                        },
                        child: const Text('Previous'),
                      ),
                      Text(
                          '$currentQuestionIndex/${questions.length} questions answered'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${questions[currentQuestionIndex].category}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${questions[currentQuestionIndex].question!.text}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(
                          questions[currentQuestionIndex].incorrectAnswers![0]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: answerClicked
                          ? questions[currentQuestionIndex]
                                      .incorrectAnswers![0] ==
                                  questions[currentQuestionIndex].correctAnswer
                              ? const Color.fromARGB(255, 42, 94, 44)
                              : Color.fromARGB(255, 120, 46, 41)
                          : null,
                    ),
                    child: Text(
                        questions[currentQuestionIndex].incorrectAnswers![0]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(
                          questions[currentQuestionIndex].incorrectAnswers![1]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: answerClicked
                          ? questions[currentQuestionIndex]
                                      .incorrectAnswers![1] ==
                                  questions[currentQuestionIndex].correctAnswer
                              ? Colors.green
                              : Colors.red
                          : null,
                    ),
                    child: Text(
                        questions[currentQuestionIndex].incorrectAnswers![1]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(
                          questions[currentQuestionIndex].incorrectAnswers![2]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: answerClicked
                          ? questions[currentQuestionIndex]
                                      .incorrectAnswers![2] ==
                                  questions[currentQuestionIndex].correctAnswer
                              ? Colors.green
                              : Colors.red
                          : null,
                    ),
                    child: Text(
                        questions[currentQuestionIndex].incorrectAnswers![2]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer(
                          '${questions[currentQuestionIndex].correctAnswer}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: answerClicked &&
                              questions[currentQuestionIndex].correctAnswer ==
                                  questions[currentQuestionIndex].correctAnswer
                          ? Colors.green
                          : null,
                    ),
                    child: Text(
                        '${questions[currentQuestionIndex].correctAnswer}'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      goToNextQuestion();
                    },
                    child: const Text('Next'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Timer: $seconds s'),
                      ElevatedButton(
                        onPressed: () {
                          // Handle view quiz result button click
                        },
                        child: const Text('View Quiz Result'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
