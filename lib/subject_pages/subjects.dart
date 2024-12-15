import 'package:flutter/material.dart';
import 'package:reddays/subject_pages/english_page.dart';
import 'package:reddays/subject_pages/filipino_page.dart';
import 'package:reddays/subject_pages/history_page.dart';
import 'package:reddays/subject_pages/math_page.dart';
import 'package:reddays/subject_pages/music_page.dart';
import 'package:reddays/subject_pages/science_page.dart';

class SubjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashcard Subjects',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            SubjectCard(
              color: Colors.yellow,
              title: "Math",
              icon: Icons.calculate,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MathPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.green,
              title: "Science",
              icon: Icons.science,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SciencePage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.grey,
              title: "Filipino",
              icon: Icons.language,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilipinoPage()),
                );
              },
            ),
            SubjectCard(
              color: Colors.orange,
              title: "History",
              icon: Icons.history_edu,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            SubjectCard(
                color: Colors.purple,
                title: "Music",
                icon: Icons.music_note,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MusicPage()),
                  );
                }),
            SubjectCard(
              color: Colors.pink,
              title: "English",
              icon: Icons.book,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnglishPage()),
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
