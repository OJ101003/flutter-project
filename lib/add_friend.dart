import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A widget for adding friends.
class AddFriend extends StatefulWidget {
  final String uID;

  /// Creates an instance of [AddFriend].
  ///
  /// Requires [uID] as a parameter.
  const AddFriend({super.key, required this.uID});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class FriendRequestInfo {
  final String uid;
  final String username;

  FriendRequestInfo(this.uid, this.username);
}
/// The state for [AddFriend].
class _AddFriendState extends State<AddFriend> {



  /// The current value of the friend field.
  String currentFriendField = "";

  /// Updates the friend field with the given value.
  void updateFriendField(String value) {
    setState(() {
      currentFriendField = value;
    });
  }

  /// Retrieves the user ID of a friend by their username.
  ///
  /// Returns null if no user is found with the given username.
  Future<String?> getFriendUidByUsername(String username) async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    try {
      // Query the users collection for a document with the matching username
      final querySnapshot = await usersCollection
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      // Check if a user document was found
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming username is unique, there should only be one match
        final userDoc = querySnapshot.docs.first;
        // Extract and return the UID from the document
        return userDoc['uid'] as String?;
      } else {
        // No user found with that username
        return null;
      }
    } catch (e) {
      print("Error getting user UID by username: $e");
      return null;
    }
  }

  void showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adding friend error'),
          content: Text("Friend not found or already added as friend or is the current user."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }


  /// Adds a friend to the current user's friends list.
  ///
  /// This does not notify the friend that they have been added.
  void addFriend(String friendID) async {
    var friendUID = await getFriendUidByUsername(friendID);
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.uID).get();

    if(friendUID != null && friendUID != widget.uID && !userDoc.data()?["friends"].contains(friendUID) && !userDoc.data()?["pendingFriends"].contains(friendUID)){
      FirebaseFirestore.instance.collection('users').doc(friendUID).update({
        'pendingFriends': FieldValue.arrayUnion([widget.uID])
      }); // This adds the current users id to the pendingFriends list of the friend
    }
    else{
      print("User not found or already added as friend or is the current user.");
      showMyDialog();
    }
    setState(() {
      currentFriendField = "";
    });

  }


  List<FriendRequestInfo> pendingFriendList = [];

  void fetchPendingFriends() async {
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.uID).get();
    var pendingFriends = userDoc.data()?["pendingFriends"] as List<dynamic>?;
    List<FriendRequestInfo> tempPendingList = [];
    for (var friendUID in pendingFriends!) {
      var username = await fetchFriendUsername(friendUID);
      // print('Adding to tempPendingList: ${FriendRequestInfo(friendUID, username).runtimeType}');
      tempPendingList.add(FriendRequestInfo(friendUID, username));
    }
    setState(() {
      pendingFriendList = tempPendingList;
    });
  }

  Future<String> fetchFriendUsername(String friendID) async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(friendID).get();
    final data = userDoc.data() as Map<String, dynamic>;
    return data['username'];
  }

  @override
  void initState() {
    super.initState();
    fetchPendingFriends();
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
                  "Pull down on the area below the friend requests text box to refresh the list of pending friend requests.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  "Friend Requests",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      fetchPendingFriends();
                    },
                    child: ListView.builder(
                      itemCount: pendingFriendList.length,

                      itemBuilder: (context, index) {
                        return FriendRequest(friendInfo: pendingFriendList[index], uID: widget.uID, fetchPendingFriends: fetchPendingFriends);
                      },
                    ),
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
  final FriendRequestInfo friendInfo;
  final String uID;
  final Function fetchPendingFriends;

  const FriendRequest({
    super.key,
    required this.friendInfo,
    required this.uID,
    required this.fetchPendingFriends
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
                friendInfo.username,
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
                // Handle the button press for accepting friend request
                FirebaseFirestore.instance.collection('users').doc(uID).update({
                  'friends': FieldValue.arrayUnion([friendInfo.uid])
                });
                FirebaseFirestore.instance.collection('users').doc(friendInfo.uid).update({
                  'friends': FieldValue.arrayUnion([uID])
                }); // This adds the current users id to the pendingFriends list of the friend

                FirebaseFirestore.instance.collection('users').doc(uID).update({
                  'pendingFriends': FieldValue.arrayRemove([friendInfo.uid])
                });
                fetchPendingFriends();

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
              // Handle the button press for declining friend request
              FirebaseFirestore.instance.collection('users').doc(uID).update({
                'pendingFriends': FieldValue.arrayRemove([friendInfo.uid])
              });
              fetchPendingFriends();
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
