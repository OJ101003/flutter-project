import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          // This is row for current pfp and upload new pfp
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 20, right: 20),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/9.jpg'),
                radius: 50,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
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
                    borderRadius: BorderRadius.circular(30), // Rounded shape
                  ),
                  minimumSize: const Size(150, 40),
                  // Set the button's minimum size
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10), // Inner padding of the button
                ),
                child: const Text(
                  'Change Profile Picture',
                  style: TextStyle(
                    fontSize: 19, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          // Current username textbox
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              // Add padding around the text field if needed
              child: TextField(
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  // Background color of the text field
                  hintText: 'Current Username',
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
            )
          ],
        ),
        Column(
          // Button for changing username
          children: [
            ElevatedButton(
              onPressed: () {
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
          // Change password box
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button press
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(width: 4, color: Colors.black),
                  backgroundColor: const Color(0xFF9D52AE),
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 24, // Set the font size
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
      ]),
    );
  }
}
