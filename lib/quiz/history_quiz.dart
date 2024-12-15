import 'package:flutter/material.dart';

import '../data/history_quiz.data.dart';

List<Map<String, dynamic>> getFormattedQuizData() {
  return historyQuiz.map((question) {
    int correctIndex = question['options'].indexOf(question['answer']);
    return {
      ...question,
      "correctIndex": correctIndex,
    };
  }).toList();
}

class AnswerSelector {
  int _selectedAnswerIndex = -1;
  bool _answered = false;

  int get selectedAnswerIndex => _selectedAnswerIndex;
  bool get answered => _answered;

  void selectAnswer(int index) {
    _selectedAnswerIndex = index;
    _answered = true;
  }

  void reset() {
    _selectedAnswerIndex = -1;
    _answered = false;
  }
}

class HistoryQuizPage extends StatefulWidget {
  @override
  _HistoryQuizPageState createState() => _HistoryQuizPageState();
}

class _HistoryQuizPageState extends State<HistoryQuizPage> {
  final List<Map<String, dynamic>> historyFlashcards = getFormattedQuizData();
  int _currentIndex = 0;
  int _score = 0;
  List<int> _highScores = [];
  AnswerSelector _answerSelector = AnswerSelector();

  void _nextQuestion() {
    if (_currentIndex >= historyFlashcards.length - 1) {
      _endQuiz();
      return;
    }

    setState(() {
      if (_answerSelector.answered) {
        if (_answerSelector.selectedAnswerIndex ==
            historyFlashcards[_currentIndex]['correctIndex']) {
          _score++;
        }
      }
      _currentIndex++;
      _answerSelector.reset();
    });
  }

  void _endQuiz() {
    setState(() {
      _highScores.add(_score);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaderboardPage(highScores: _highScores),
      ),
    );
  }

  void _showAnswerDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Wrong'),
          content: Text(
            isCorrect
                ? 'Great job! You chose the correct answer.'
                : 'Oops! The correct answer was: ${historyFlashcards[_currentIndex]['options'][historyFlashcards[_currentIndex]['correctIndex']]}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _nextQuestion(); // Move to the next question
              },
              child: Text('Next Question'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= historyFlashcards.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Completed'),
          backgroundColor: Colors.blue[700],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score: $_score/${historyFlashcards.length}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    _score = 0;
                    _answerSelector.reset();
                  });
                },
                child: Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final currentCard = historyFlashcards[_currentIndex];
    final question = currentCard['question'] ?? 'Question not available';
    final correctIndex = currentCard['correctIndex'] ?? -1;

    return Scaffold(
      appBar: AppBar(
        title: Text('History Quiz'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${historyFlashcards.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Flashcard(
              question: question,
              options: currentCard['options'] != null
                  ? List<String>.from(currentCard['options'])
                  : [],
              correctIndex: correctIndex,
              onAnswerSelected: (int index) {
                _answerSelector.selectAnswer(index);
                setState(() {
                  bool isCorrect =
                      _answerSelector.selectedAnswerIndex == correctIndex;
                  _showAnswerDialog(isCorrect);
                });
              },
              answerSelector: _answerSelector,
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard extends StatelessWidget {
  final String question;
  final List<String> options;
  final int correctIndex;
  final Function(int) onAnswerSelected;
  final AnswerSelector answerSelector;

  const Flashcard({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.onAnswerSelected,
    required this.answerSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return RadioListTile<int>(
                value: index,
                groupValue: answerSelector.selectedAnswerIndex,
                title: Text(option),
                onChanged: answerSelector.answered
                    ? null
                    : (value) {
                        onAnswerSelected(value!);
                      },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  final List<int> highScores;

  LeaderboardPage({required this.highScores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Top Scores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: highScores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Score ${index + 1}: ${highScores[index]}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}