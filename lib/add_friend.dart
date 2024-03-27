import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class AddFriend extends StatefulWidget {
  final String uID;

  const AddFriend({super.key, required this.uID});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {

  String currentFriendField = "";

  void updateFriendField(String value) {
    setState(() {
      currentFriendField = value;
    });
  }

  // Current implementation just adds the friend to the current user's friends list
  // This doesn't notify the friend that they have been added.
  void addFriend(String friendID) async {
    FirebaseFirestore.instance.collection('users').doc(widget.uID).update({
      'friends': FieldValue.arrayUnion([friendID])
    });
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
          'Add Friends',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: (Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                // Add padding around the text field if needed
                child: TextField(
                  onChanged: (value) {
                    updateFriendField(value);
                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    // Background color of the text field
                    hintText: 'Enter Friend Username',
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
              )))
            ],
          ),
          Expanded(
            flex: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    addFriend(currentFriendField);
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
                    'Add Friend',
                    style: TextStyle(
                      fontSize: 25, // Set the font size
                      fontWeight: FontWeight.bold, // Set the font weight
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(children: [
                const Text(
                  "Friend Requests",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Expanded(
                  child: ListView(
                    children: const [
                      FriendRequest(),
                      FriendRequest(),
                      FriendRequest(),
                      FriendRequest()
                    ],
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class FriendRequest extends StatelessWidget {
  final String username;

  const FriendRequest({
    super.key,
    this.username = "Username",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 5.0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                username,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {
                // Handle the button press
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 4, color: Colors.black),
                backgroundColor: Colors.green,
                // Button background color to green
                foregroundColor: Colors.white,
                // Icon color
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(70, 50),
                // Adjust the size as needed
                padding:
                    const EdgeInsets.all(10), // Adjust the padding as needed
              ),
              child: const Icon(
                Icons.check, // Checkmark icon
                size: 25, // Adjust the icon size as needed
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the button press
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 4, color: Colors.black),
              backgroundColor: Colors.red,
              // Button background color to red
              foregroundColor: Colors.white,
              // Icon color
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(70, 50),
              // Adjust the size as needed
              padding: const EdgeInsets.all(10), // Adjust the padding as needed
            ),
            child: const Icon(
              Icons.close, // "X" icon for close
              size: 25, // Adjust the icon size as needed
              color: Colors.white, // Icon color set to white for contrast
            ),
          )
        ],
      ),
    );
  }
}
