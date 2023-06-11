import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_goods/views/buyers/nav_screens/login_screen.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({Key? key}) : super(key: key);

  @override
  _AccountscreenState createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _name = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot snapshot =
          await _firestore.collection('buyers').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          _name = snapshot.get('name') ?? '';
          _email = snapshot.get('email') ?? '';
          _phone = snapshot.get('phone') ?? '';
        });
      }
    }
  }

  void _logoutUser(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: $_name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: $_email',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Phone Number: $_phone',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Edit Profile'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _logoutUser(context);
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
