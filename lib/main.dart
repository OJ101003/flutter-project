import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:now_me/add_friend.dart';
import 'package:now_me/profile_page.dart';
import 'package:now_me/login_page.dart';
import 'package:now_me/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  String username = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    loadUsername();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        fetchFriends(); // Ensures fetching of friends occurs after the initial build
      }
    });
  }

  var friendList = <Friend>{}; // Create an empty list of friends

  Future<List> fetchFriendInfo(String UID) async {
    try {
      final friendSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(UID).get();
      final friendUsername = friendSnapshot.data()?['username'] as String;
      final friendImagePath =
      friendSnapshot.data()?['profilePicture'] as String;
      final friendTimeUpdated =
      friendSnapshot.data()?['timeUpdated'];
      final friendStatus = friendSnapshot.data()?['currentStatus'] as String;
      return [
        friendUsername,
        friendImagePath,
        friendTimeUpdated,
        friendStatus
      ];
    } catch (e) {
      print("Error fetching friend info: $e");
      return [];
    }
  }

  // Fetch friends from Firestore and stores them into the friends list
  // The friends list can be accessed anywhere

  void fetchFriends() async {
    try {
      var friendsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get(); // List of UIDS
      var friendsUids = friendsSnapshot.data()?['friends'] as List<dynamic>?; // Ensure it's treated as a nullable list
      if (friendsUids != null) {
        var temp = <Friend>{}; // Create a temporary list to store friends
        for (var friendUid in friendsUids) {
          var friendInfo = await fetchFriendInfo(friendUid);
          temp.add(Friend(friendInfo[0], friendUid, friendInfo[1], friendInfo[2] as Timestamp, friendInfo[3]));
        }
        setState(() {
          friendList = temp; // Update the state with the fetched friends
        });
      }
    } catch (e) {
      print("Error fetching friends: $e");
    }
    for (var friend in friendList) {
      print(friend.username);
    }
  }


  /// Fetches the username of the current user
  ///
  /// Returns the username if it exists, otherwise returns null
  ///
  /// Uses the existing Firebase uid to fetch the username from the 'users' collection
  Future<String?> fetchUsername() async {
    // Assuming the user is logged in and you have their UID
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      print("User is not logged in");
      return null;
    } else {
      setUid(uid);
    }

    try {
      // Access the 'users' collection and get the document by UID
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Assuming 'username' field exists in the document
        final username = docSnapshot.data()?['username'] as String?;
        return username;
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user document: $e");
      return null;
    }
  }

  void loadUsername() async {
    final username = await fetchUsername();
    if (username != null) {
      setState(() {
        // Assuming you have a state variable to hold the username
        this.username = username;
      });
    }
  }

  void setUid(String uid) {
    setState(() {
      this.uid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage(
          username: username,
          uid: uid,
          friendList: friendList,
        );
        break;
      case 1:
        page = ProfilePage(
          username: username,
        );
        break;
      default:
        page = MainPage(
          username: username,
          uid: uid,
          friendList: friendList,
        );
        break;
    }
    void setIndex(int index) {
      setState(() {
        selectedIndex = index;
      });
      if(index == 0){
        fetchFriends();
      }
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

class Friend {
  final String username;
  final String uid;
  final String profilePicture;
  final Timestamp timeUpdated;
  final String currentStatus;

  Friend(this.username, this.uid, this.profilePicture, this.timeUpdated,
      this.currentStatus);
}

class MainPage extends StatelessWidget {
  final String username;
  final String uid;
  final Set<Friend> friendList;

  const MainPage({
    super.key,
    required this.username,
    required this.uid,
    required this.friendList,
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
                child: Center(
                  child: Text(
                    username,
                    style: const TextStyle(fontSize: 20),
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
                            builder: (context) => AddFriend(
                                  uID: uid,
                                )));
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
          child: ListView.separated(
            itemCount: friendList.length,
            itemBuilder: (BuildContext context, int index) {
              // Convert the Set to a List and access by index
              var friend = friendList.toList()[index];
              return FriendHomePage(
                imagePath: friend.profilePicture,
                username: friend.username,
                lastUpdated: friend.timeUpdated.toDate().toString(),
                status: friend.currentStatus,
              );
            },
            separatorBuilder: (BuildContext context, int index) => const LineDivider(),
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
