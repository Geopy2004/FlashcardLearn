import 'package:flutter/material.dart';
import 'package:reddays/data/music_quiz_data.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  void _showNextCard() {
    setState(() {
      if (_currentIndex < musicQuizData.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _showPreviousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music - Flashcards',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title Section
            Text(
              'Music Flashcards',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enhance your Music knowledge and skills!',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            SizedBox(height: 20),

            // Flashcard
            Flashcard(
              question: musicQuizData[_currentIndex]['question']!,
              answer: musicQuizData[_currentIndex]['answer']!,
            ),
            SizedBox(height: 20),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? _showPreviousCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade400,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Previous'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _currentIndex < musicQuizData.length - 1
                      ? _showNextCard
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade400,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard extends StatefulWidget {
  final String question;
  final String answer;

  const Flashcard({
    required this.question,
    required this.answer,
  });

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> with TickerProviderStateMixin {
  bool _showAnswer = false;

  void _toggleAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: _toggleAnswer,
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(vertical: 12),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _showAnswer ? widget.answer : widget.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color:
                        _showAnswer ? Colors.purple.shade700 : Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _showAnswer
                      ? 'Tap to show the question'
                      : 'Tap to show the answer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}