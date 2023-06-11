import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/login_screen.dart';

class Accountscreen extends StatelessWidget {
  const Accountscreen({Key? key}) : super(key: key);

  void _logoutUser(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    'Name: User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: user@example.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone Number: 1234567890',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement edit profile logic
                        },
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
    );
  }
}
