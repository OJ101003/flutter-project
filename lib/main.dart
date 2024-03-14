import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:now_me/add_friend.dart';
import 'package:now_me/profile_page.dart';
import 'package:now_me/login_page.dart';
import 'package:now_me/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NowMe',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MyHomePage(),
      },
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade900),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF4E4E4E)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const MainPage();
      case 1:
        page = const ProfilePage();
      default:
        page = const MainPage();
    }
    void setIndex(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        toolbarHeight: 0,
      ),
      body: page,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade900,
        // Set your desired color for the BottomAppBar
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Left oval button with text
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                // This will give it an oval shape
                child: Material(
                  color: selectedIndex == 0
                      ? const Color(0xFF6452AE)
                      : Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.green, // Splash color on tap
                    onTap: () {
                      setIndex(0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 34, vertical: 18), // Give it some padding
                      child: const Text(
                        'Friends',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Right oval button with text
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Material(
                  color: selectedIndex == 1
                      ? const Color(0xFF6452AE)
                      : Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.green,
                    onTap: () {
                      setIndex(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 34, vertical: 18),
                      child: const Text(
                        'Profile Page',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Container(
                width: 280,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Your username here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: RawMaterialButton(
                  onPressed: () {
                    // Handle the button press
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddFriend()));
                  },
                  elevation: 2.0,
                  fillColor: Colors.blueGrey,
                  padding: const EdgeInsets.all(20.0),
                  shape: const CircleBorder(side: BorderSide(width: 5.0)),
                  child: const Icon(
                    Icons.add,
                    size: 50.0,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          // Wrap the ListView in an Expanded widget
          child: ListView(
            children: const [
              FriendHomePage(
                imagePath: 'assets/images/1.jpg',
                username: "Random person",
                lastUpdated: '3 hours ago',
                status: 'Doing Homework',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/2.jpg',
                username: "Someone else",
                lastUpdated: '4 days ago',
                status: 'Pulling all nighter',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/7.jpg',
                username: "Another person",
                lastUpdated: '2 minutes ago',
                status: 'Sleeping',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/3.jpg',
                username: "Guy from high school",
                lastUpdated: '4 hours ago',
                status: 'Working',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/4.jpg',
                username: "Local hobo",
                lastUpdated: 'Just now',
                status: 'Wandering around',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/8.jpg',
                username: "Another person",
                lastUpdated: '2 minutes ago',
                status: 'Sleeping',
              ),
              LineDivider(),
              FriendHomePage(
                imagePath: 'assets/images/5.jpg',
                username: "Another person",
                lastUpdated: '2 minutes ago',
                status: 'Sleeping',
              ),
              // Add more FriendHomePage widgets as needed
            ],
          ),
        ),
      ],
    );
  }
}

class LineDivider extends StatelessWidget {
  const LineDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 35,
      thickness: 1,
      indent: 5,
      endIndent: 5,
      color: Colors.white,
    );
  }
}

class FriendHomePage extends StatelessWidget {
  final String imagePath;
  final String username;
  final String lastUpdated;
  final String status;

  const FriendHomePage({
    super.key,
    required this.imagePath,
    this.username = 'Username',
    this.lastUpdated = 'Today',
    this.status = 'Nothing',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: IntrinsicHeight(
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 40,
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Last Updated: $lastUpdated'),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                width: 15,
                thickness: 1,
                indent: 10,
                endIndent: 0,
                color: Colors.white,
              ),
              Expanded(
                flex: 4,
                child: Center(
                    child: Text(
                  status,
                  style: const TextStyle(fontSize: 28),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
