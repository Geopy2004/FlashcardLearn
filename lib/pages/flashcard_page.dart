import 'package:flutter/material.dart';
import 'package:reddays/quiz/quiz_page.dart';
import 'package:reddays/subject_pages/subjects.dart';

class FlashcardQuizHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashcard & Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2, // Added letter-spacing for style
          ),
        ),
        centerTitle: true,
        elevation: 4, // Custom elevation to add depth
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20.0), // Added more padding for spacious look
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 26, // Larger font size
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2, // Added letter-spacing for style
              ),
            ),
            SizedBox(height: 30),
            // Flashcards Option
            MenuCard(
              title: 'Flashcards',
              color: Colors.blueAccent,
              icon: Icons.note_alt_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectsScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            // Quiz Option
            MenuCard(
              title: 'Quiz',
              color: Colors.greenAccent,
              icon: Icons.quiz_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Quiz()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  MenuCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white30,
      borderRadius:
          BorderRadius.circular(16), // More rounded corners for a modern feel
      child: Container(
        height: 90, // Increased height for better touch area
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), // Gradient for a more vibrant look
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ], // Subtle shadow for depth
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28, // Slightly larger radius for the icon container
                child: Icon(
                  icon,
                  color: color,
                  size: 32, // Slightly bigger icon for better emphasis
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22, // Slightly larger text for readability
                    fontWeight:
                        FontWeight.w600, // Lighter weight for better emphasis
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18, // Adjusted the arrow size
              ),
            ],
          ),
        ),
      ),
    );
  }
}
