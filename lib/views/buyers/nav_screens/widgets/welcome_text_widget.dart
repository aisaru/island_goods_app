import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeText extends StatelessWidget {
  final String userName;

  const WelcomeText({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final userData = snapshot.data!;
          final userName = userData['name'] ??
              'User'; // Default to 'User' if name is not available
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 25,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error retrieving user data');
        } else {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        }
      },
    );
  }
}
