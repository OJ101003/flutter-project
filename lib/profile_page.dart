import 'package:flutter/material.dart';
import 'package:now_me/create_status.dart';
import 'package:now_me/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentStatus = "";

  @override
  void initState() {
    super.initState();
    // Immediately executed async function.
    () async {
      final status = await getStatus(); // Use await here.
      final statusList = await getStatusList();
      if (mounted) { // Check if the widget is still in the tree.
        setState(() {
          currentStatus = status ?? ""; // Update the state with the fetched status.
          buttonLabels.addAll(statusList); // Add the status list to the button labels.
        });
      }
    }(); // Note the parentheses to call this anonymous async function.
  }


  Future<String?> getStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) return null; // Return null if there's no user logged in.
      final userData = await FirebaseFirestore.instance.collection('users').doc(user).get();
      return userData['currentStatus'] as String?;
    } catch (e) {
      print("Error fetching status: $e");
      return null; // Handle exceptions by returning null or a default value.
    }
  }

  Future<List<String>> getStatusList() async{
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) return []; // Return an empty list if there's no user logged in.
      final userData = await FirebaseFirestore.instance.collection('users').doc(user).get();
      return List<String>.from(userData['statusList'] as List<dynamic>);
    } catch (e) {
      print("Error fetching status list: $e");
      return []; // Handle exceptions by returning an empty list or a default value.
    }
  }

  void updateStatus(String newStatus) async {
    try {
      final user = FirebaseAuth.instance.currentUser?.uid;
      if (user == null) return; // Return if there's no user logged in.
      await FirebaseFirestore.instance.collection('users').doc(user).update({
        'currentStatus': newStatus,
        'timeUpdated': FieldValue.serverTimestamp(),
      });
      setState(() {
        currentStatus = newStatus;
      });
    } catch (e) {
      print("Error updating status: $e");
    }
  }

  // var currentStatus = getStatus();
  final List<String> buttonLabels = [
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
                  ).then((result){
                    if(result != null){
                      setState(() {
                        if(result as String != ""){
                          buttonLabels.add(result);
                        }
                      });
                    }
                  });
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
                      updateStatus(buttonLabels[firstButtonIndex]);
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
                        updateStatus(buttonLabels[secondButtonIndex]);
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
