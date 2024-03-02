import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          title: const Text('Login'),
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // Title
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "NowMe",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          inherit: true,
                          fontSize: 74.0,
                          color: Color(0xFF212121),
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-3, -3),
                                color: Color(0xFF836DE7)),
                            Shadow(
                                // bottomRight
                                offset: Offset(3, -3),
                                color: Color(0xFF836DE7)),
                            Shadow(
                                // topRight
                                offset: Offset(3, 3),
                                color: Color(0xFF836DE7)),
                            Shadow(
                                // topLeft
                                offset: Offset(-3, 3),
                                color: Color(0xFF836DE7)),
                          ]),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    // Username text box
                    children: [
                      Expanded(
                          child: (Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: UsernameTextField(outlineInputBorder: outlineInputBorder),
                      )))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        // Add padding around the text field if needed
                        child: PasswordTextField(outlineInputBorder: outlineInputBorder),
                      )))
                    ],
                  ),
                  Row(
                    // Forgot password
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle the button press
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20, // Set the font size
                            fontWeight: FontWeight.bold, // Set the font weight
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Sign in button
                        children: [
                          SignInButton(),
                        ],
                      ),
                    ),
                    const Row(
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
        Navigator.pushNamed(context, '/register');
      },
      style: ElevatedButton.styleFrom(
        side:
            const BorderSide(width: 4, color: Colors.black),
        backgroundColor: const Color(0xFF6452AE),
        // Button background color
        foregroundColor: Colors.white,
        // Text color
        elevation: 3,
        // Button shadow elevation
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded shape
        ),
        minimumSize: const Size(230, 70.0),
        // Set the button's minimum size
        padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10), // Inner padding of the button
      ),
      child: const Text(
        'Create Account',
        style: TextStyle(
          fontSize: 25, // Set the font size
          fontWeight:
              FontWeight.bold, // Set the font weight
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.outlineInputBorder,
  });

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        // Background color of the text field
        hintText: 'Password',
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
            vertical:
                25.0), // Padding inside the text field
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        // Background color of the text field
        hintText: 'Username',
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
            vertical:
                25.0), // Padding inside the text field
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle the button press
        Navigator.pushNamed(context, '/main');
      },
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
            width: 4, color: Colors.black),
        backgroundColor: const Color(0xFF6452AE),
        // Button background color
        foregroundColor: Colors.white,
        // Text color
        elevation: 3,
        // Button shadow elevation
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Rounded shape
        ),
        minimumSize: const Size(230, 70.0),
        // Set the button's minimum size
        padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10), // Inner padding of the button
      ),
      child: const Text(
        'Sign in',
        style: TextStyle(
          fontSize: 25, // Set the font size
          fontWeight:
              FontWeight.bold, // Set the font weight
        ),
      ),
    );
  }
}
