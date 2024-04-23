import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String newUsername = '';

  void updateUsernameField(String value) {
    setState(() {
      newUsername = value;
    });
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) { // Check if the widget is still in the widget tree
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (error) {
      print("Sign out error: $error");
    }
  }

  void deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) return; // Return if there's no user logged in.
      await FirebaseFirestore.instance.collection('users').doc(user).delete();
      await FirebaseAuth.instance.currentUser?.delete();
      if (mounted) { // Check if the widget is still in the widget tree
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      print("Error deleting account: $e");
    }
  }

  void updateUsername(String newUsername) async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) return; // Return if there's no user logged in.
      await FirebaseFirestore.instance.collection('users').doc(user).update({
        'username': newUsername,
      });
    } catch (e) {
      print("Error updating status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      // This is for the input border since the code was repetitive
      borderRadius: BorderRadius.circular(10.0),
      // Rounded corners
      borderSide: const BorderSide(
        color: Colors.black,
        // Border color, use same as border color
        width:
            5.0, // This is the width of the border when the TextField is enabled but not focused
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(5), // Adjust margin for positioning
          decoration: const BoxDecoration(
            color: Color(0xFF6452AE), // Background color
            shape: BoxShape.circle, // Circular background
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
            // Adjust icon size and color
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // This is row for current pfp and upload new pfp
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/9.jpg'),
                radius: 60,
              ),
            ),
          ],
        ),
        Column(
          // Current username textbox
          children: [
            Container(
              // margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              // Add padding around the text field if needed
              child: Column(
                children: [
                  const Text(
                    "Username change reflected on next login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  TextField(
                    onChanged: (value) => updateUsernameField(value),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      // Background color of the text field
                      hintText: 'New Username',
                      hintStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      // Placeholder text
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 25.0), // Padding inside the text field
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          // Button for changing username
          children: [
            ElevatedButton(
              onPressed: () {
                updateUsername(newUsername);
                // Handle the button press
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 4, color: Colors.black),
                backgroundColor: const Color(0xFF6452AE),
                // Button background color
                foregroundColor: Colors.white,
                // Text color
                elevation: 2,
                // Button shadow elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded shape
                ),
                minimumSize: const Size(150, 40),
                // Set the button's minimum size
                padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10), // Inner padding of the button
              ),
              child: const Text(
                'Change Username',
                style: TextStyle(
                  fontSize: 24, // Set the font size
                  fontWeight: FontWeight.bold, // Set the font weight
                ),
              ),
            ),
          ],
        ),
        Column(
          // Delete account username
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: ElevatedButton(
                onPressed: () {
                  deleteAccount();
                  // Handle the button press
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 4, color: Colors.black),
                  backgroundColor: const Color(0xFFD52F47),
                  // Button background color
                  foregroundColor: Colors.white,
                  // Text color
                  elevation: 2,
                  // Button shadow elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded shape
                  ),
                  minimumSize: const Size(150, 40),
                  // Set the button's minimum size
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10), // Inner padding of the button
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 34, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          // Delete account username
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: ElevatedButton(
                onPressed: () {
                  signOut();
                  // Handle the button press
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 4, color: Colors.black),
                  backgroundColor: const Color(0xFF6452AE),
                  // Button background color
                  foregroundColor: Colors.white,
                  // Text color
                  elevation: 2,
                  // Button shadow elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded shape
                  ),
                  minimumSize: const Size(150, 40),
                  // Set the button's minimum size
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10), // Inner padding of the button
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 34, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
