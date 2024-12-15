import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddays/pages/flashcard_page.dart';
import 'package:reddays/pages/leaderboard_page.dart';
import 'package:reddays/pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user;
  String username = "Adventurer"; // Default username
  int _currentIndex = 0; // Tracks the selected tab
  late PageController _pageController; // Controller for PageView

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _pageController = PageController(); // Initialize PageController
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? "Adventurer";
          });
        }
      } catch (e) {
        print("Error fetching username: $e");
        setState(() {
          username = "Adventurer"; // Fallback username in case of an error
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Reduced AppBar height
        child: AppBar(
          backgroundColor: Colors.blue, // Standard blue color
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0), // Reduced padding
            child: Row(
              children: [
                Image.asset(
                  'assets/images/magi.png', // Replace with your app's icon
                  height: 40, // Reduced size for app icon
                  width: 40,
                ),
                const SizedBox(width: 4), // Reduced space between icon and text
                const Text(
                  'Flashcarton',
                  style: TextStyle(
                    fontSize: 18, // Reduced font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue, // Standard blue color
              Colors.grey, // Grey color
              Colors.black, // Black color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centered alignment
          children: [
            const SizedBox(height: 20), // Reduced space for top area

            // Show greeting only on the first page (Home)
            if (_currentIndex == 0) ...[
              // Personalized greeting with username
              Text(
                "Welcome, $username!",
                style: const TextStyle(
                  fontSize: 24, // Reduced font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              // Directly following the "Welcome" text, without extra space
              Text(
                "Let's get started.",
                style: const TextStyle(
                  fontSize: 20, // Reduced font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Reduced space before page content
            ],

            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  // Home Page: Greeting will be here
                  Center(
                    child: Text(
                      "", // Home page content can be added here if necessary
                      style: const TextStyle(
                        fontSize: 20, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  LeaderboardScreen(),
                  FlashcardQuizHome(),
                  SettingsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut, // Smooth transition
            );
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "Leaderboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "Flashcards",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
