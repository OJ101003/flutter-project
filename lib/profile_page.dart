import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/9.jpg'),
                  radius: 65,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const Text(
                        "User Name",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6452AE), // Button background color
                        foregroundColor: Colors.white, // Text color
                        elevation: 5, // Button shadow elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded shape
                        ),
                        minimumSize: const Size(150, 40), // Set the button's minimum size
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), // Inner padding of the button
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20, // Set the font size
                          fontWeight: FontWeight.bold, // Set the font weight
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ), // Top part with pfp, username, and edit profile button
        const Row(), // Row with create status and current status
        Expanded(
            child: ListView(
                // This is where the list of all the buttons will go, each button row will be it's own widget
                ))
      ],
    );
  }
}
