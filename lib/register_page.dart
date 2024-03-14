import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                            outlineInputBorder: outlineInputBorder),
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
                            outlineInputBorder: outlineInputBorder),
                      )))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: PasswordTextField(
                            outlineInputBorder: outlineInputBorder,
                            confirmText: "Password"),
                      )))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: PasswordTextField(
                            outlineInputBorder: outlineInputBorder,
                            confirmText: "Confirm Password"),
                      )))
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Register button
                      children: [
                        CreateAccountButton(),
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
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/main');
      },
      style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 4, color: Colors.black),
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

class PasswordTextField extends StatelessWidget {
  final String confirmText;

  const PasswordTextField(
      {super.key,
      required this.outlineInputBorder,
      this.confirmText = "Password"});

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
  const EmailTextField({
    super.key,
    required this.outlineInputBorder,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
  const UsernameTextField({
    super.key,
    required this.outlineInputBorder,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
