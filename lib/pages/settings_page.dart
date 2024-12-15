import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'contact_page.dart'; // Import your contacts page

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  // Log out function
  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .pushReplacementNamed('/signin'); // Redirect to login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error logging out: $e"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Show About Us dialog
  void _showAboutUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("About Us",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          "Flashcarton is an innovative flashcard app designed to make learning easy and fun. "
          "Developed by passionate creators, we aim to help students and professionals alike achieve their goals.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // Navigate to the contacts page
  void _goToContactsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactsPage()), // Navigate to ContactsPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true, // Center the title
        elevation: 4, // Slight shadow for depth
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About Us option
            _buildListTile(
              icon: Icons.info_outline,
              iconColor: Colors.blue,
              title: "About Us",
              onTap: () => _showAboutUsDialog(context),
            ),
            const Divider(),

            // Contact option
            _buildListTile(
              icon: Icons.contact_mail,
              iconColor: Colors.green,
              title: "Contact",
              onTap: () => _goToContactsPage(context),
            ),
            const Divider(),

            // Logout option
            _buildListTile(
              icon: Icons.logout,
              iconColor: Colors.red,
              title: "Logout",
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable ListTile with background, icon, and onTap action
  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        leading: CircleAvatar(
          backgroundColor:
              iconColor.withOpacity(0.1), // Light background for contrast
          radius: 25,
          child: Icon(icon, color: iconColor, size: 30),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onTap: onTap,
      ),
    );
  }
}
