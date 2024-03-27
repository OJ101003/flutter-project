import 'package:flutter/material.dart';
import 'package:now_me/create_status.dart';
import 'package:now_me/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentStatus = "Current Status";
  final List<String> buttonLabels = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 1',
    'Button 2',
    // Add as many button labels as you need
  ];



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
                      child: Text(
                        widget.username,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Change page to edit profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()),
                        );
                        // Handle the button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6452AE),
                        // Button background color
                        foregroundColor: Colors.white,
                        // Text color
                        elevation: 5,
                        // Button shadow elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded shape
                        ),
                        minimumSize: const Size(150, 40),
                        // Set the button's minimum size
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10), // Inner padding of the button
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
        Container(
          margin: const EdgeInsets.only(top: 20, left: 7, right: 7, bottom: 10),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateStatus()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6452AE),
                  // Button background color
                  foregroundColor: Colors.white,
                  // Text color
                  elevation: 5,
                  // Button shadow elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded shape
                  ),
                  minimumSize: const Size(140, 75),
                  // Set the button's minimum size
                  // Inner padding of the button
                ),
                child: const Text(
                  'Create Status',
                  style: TextStyle(
                    fontSize: 20, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      currentStatus,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ), // Row with create status and current status
        Expanded(
          child: ListView.builder(
            itemCount: (buttonLabels.length / 2).ceil(),
            // Calculate the number of rows needed
            itemBuilder: (context, index) {
              int firstButtonIndex = index * 2;
              List<Widget> rowChildren = [
                CustomButton(
                  label: buttonLabels[firstButtonIndex],
                  onPressed: () {
                    setState(() {
                      currentStatus = buttonLabels[firstButtonIndex];
                    });
                  },
                ),
              ];

              int secondButtonIndex = firstButtonIndex + 1;
              if (secondButtonIndex < buttonLabels.length) {
                rowChildren.add(
                  CustomButton(
                    label: buttonLabels[secondButtonIndex],
                    onPressed: () {
                      setState(() {
                        currentStatus = buttonLabels[secondButtonIndex];
                      });
                    },
                  ),
                );
              }

              return Row(children: rowChildren);
            },
          ),
        )
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD9D9D9),
            // Button background color
            foregroundColor: Colors.white,
            // Text color
            elevation: 5,
            // Button shadow elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded shape
            ),
            minimumSize: const Size(140, 75), // Set the button's minimum size
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
