import 'package:flutter/material.dart';
import 'package:reddays/quiz/english_quiz.dart';
import 'package:reddays/quiz/filipino_quiz.dart';
import 'package:reddays/quiz/history_quiz.dart';
import 'package:reddays/quiz/math_quiz.dart';
import 'package:reddays/quiz/music_quiz.dart';
import 'package:reddays/quiz/science_quiz.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Subjects',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            SubjectCard(
              color: Colors.redAccent,
              title: "Math Quiz",
              icon: Icons.calculate,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MathQuizPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.lightBlue,
              title: "Science Quiz",
              icon: Icons.science,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScienceQuizPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.grey,
              title: "Filipino Quiz",
              icon: Icons.language,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilipinoQuizPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.orangeAccent,
              title: "History Quiz",
              icon: Icons.history_edu,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryQuizPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.purple,
              title: "Music Quiz",
              icon: Icons.music_note,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicQuizPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.pinkAccent,
              title: "English Quiz",
              icon: Icons.book,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnglishQuizPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SubjectCard({
    required this.color,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
