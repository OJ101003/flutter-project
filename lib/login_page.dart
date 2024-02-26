import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 40,
            child: Image(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/en/b/bd/Random_App_Logo.png'),
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: const TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        width: 200,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.amber),
                            ),
                            onPressed: () {},
                            child: const Text("Login"))))
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("App Logo"),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.volume_down),
                  tooltip: 'Decrease volume by 10',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
