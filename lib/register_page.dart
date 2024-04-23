import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String password = "";
  String confirmPassword = "";
  String username = "";

  void updateUsername(String newUsername) {
    setState(() {
      username = newUsername;
    });
  }

  void updateEmail(String newEmail) {
    setState(() {
      email = newEmail;
    });
  }

  void updatePassword(String newPassword) {
    setState(() {
      password = newPassword;
    });
  }

  void updateConfirmPassword(String newConfirmPassword) {
    setState(() {
      confirmPassword = newConfirmPassword;
    });
  }

  bool checkPassword() {
    return password == confirmPassword;
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
        ));

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
            'Create Account',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    // Username text box
                    children: [
                      Expanded(
                          child: (Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: UsernameTextField(
                            outlineInputBorder: outlineInputBorder,
                            onUsernameChange: updateUsername),
                      )))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: EmailTextField(
                          outlineInputBorder: outlineInputBorder,
                          onEmailChange: updateEmail,
                        ),
                      )))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              // Add padding around the text field if needed
                              child: PasswordTextField(
                                outlineInputBorder: outlineInputBorder,
                                confirmText: "Password",
                                onPasswordChange: updatePassword,
                              ))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              // Add padding around the text field if needed
                              child: PasswordTextField(
                                outlineInputBorder: outlineInputBorder,
                                confirmText: "Confirm Password",
                                onPasswordChange: updateConfirmPassword,
                              ))))
                    ],
                  ),
                ],
              ),
            ),
            // What I'm thinking is maybe we have another variable as password, and then we can have a function that checks if the password and confirm password are the same.
            // That function will be in the confirmPassword textfield, and we detect onchange for the confirm password textfield and then call the function to check if the passwords are the same.
            // If they are the same, then we can enable the create account button, if not, then we disable the create account button and make the textbox border red.
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Register button
                      children: [
                        CreateAccountButton(
                          email: email,
                          password: password,
                          checkPassword: checkPassword,
                          username: username,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class CreateAccountButton extends StatelessWidget {
  final String email;
  final String password;
  final String username;
  final Function() checkPassword;

  const CreateAccountButton({
    super.key,
    required this.email,
    required this.password,
    required this.checkPassword,
    required this.username,
  });

  Color setColor() {
    if (checkPassword()) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(String? uid, String createdEmail, String createdUsername) {
      if (uid == null) {
        print("UID is null, cannot add user without a UID.");
        return Future.error("UID is null");
      }

      // Use doc(uid) to specify the document ID
      return users
          .doc(uid)
          .set({
        'email': createdEmail,
        'username': createdUsername, // Assuming you want to add a username
        'friends': [],
        'pendingFriends': [],
        'currentStatus': 'Online',
        'statusList': [],
        'profilePicture': 'assets/images/1.jpg',
        'uid': uid,
        'timeUpdated': FieldValue.serverTimestamp(),
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ElevatedButton(
      onPressed: () async {
        // Create account button
        if (checkPassword()) {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((UserCredential userCredential) {
            String? uid = userCredential.user?.uid; // User UID from Firebase
            // We want to store the user's UID in the database alongside the username
            addUser(uid, email, username);
            Navigator.pushReplacementNamed(context, '/');
            print("The user's UID is: $uid");
          }
          ).catchError((error) {
            print(error);
          });
        }

         Navigator.pushReplacementNamed(context, '/');
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 4, color: setColor()),
        backgroundColor: const Color(0xFF6452AE),
        // Button background color
        foregroundColor: Colors.white,
        // Text color
        elevation: 3,
        // Button shadow elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded shape
        ),
        minimumSize: const Size(330, 90.0),
        // Set the button's minimum size
        padding: const EdgeInsets.symmetric(
            horizontal: 25, vertical: 10), // Inner padding of the button
      ),
      child: const Text(
        'Create Account',
        style: TextStyle(
          fontSize: 25, // Set the font size
          fontWeight: FontWeight.bold, // Set the font weight
        ),
      ),
    );
  }
}

// Pass the onPasswordChange function to the PasswordTextField widget
// We can pass either the confirmText or the onPasswordChange function to the PasswordTextField widget
// Then we'll have a separate thing that checks if the password and confirm password are the same
// If they are the same, then we can enable the create account button, if not, then we disable the create account button and make the textbox border red.

class PasswordTextField extends StatelessWidget {
  final String confirmText;
  final Function(String) onPasswordChange;

  const PasswordTextField(
      {super.key,
      required this.outlineInputBorder,
      this.confirmText = "Password",
      required this.onPasswordChange});

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        onPasswordChange(text);
      },
      obscureText: true,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        // Background color of the text field
        hintText: confirmText,
        hintStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        // Placeholder text
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 25.0, vertical: 25.0), // Padding inside the text field
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final Function(String) onEmailChange;

  const EmailTextField({
    super.key,
    required this.outlineInputBorder,
    required this.onEmailChange,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        onEmailChange(text);
      },
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        // Background color of the text field
        hintText: 'Email',
        hintStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        // Placeholder text
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 25.0, vertical: 25.0), // Padding inside the text field
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  final Function(String) onUsernameChange;
  const UsernameTextField({
    super.key,
    required this.outlineInputBorder,
    required this.onUsernameChange,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        onUsernameChange(text);
      },
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        // Background color of the text field
        hintText: 'Username',
        hintStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        // Placeholder text
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 25.0, vertical: 25.0), // Padding inside the text field
      ),
    );
  }
}
