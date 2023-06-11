import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:island_goods/views/buyers/main_screen.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 251, 123, 4),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 251, 123, 4),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 251, 123, 4),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone number",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 251, 123, 4),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 149, 0, 1),
                            Color.fromRGBO(240, 198, 140, 1),
                          ],
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _signupUser(context);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already a user? Back to Login",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 149, 0, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signupUser(BuildContext context) async {
    try {
      final String name = nameController.text.trim();
      final String email = emailController.text.trim();
      final String phone = phoneController.text.trim();
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;

      // Validate fields
      if (name.isEmpty ||
          email.isEmpty ||
          phone.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        print('Please fill all fields');
        return;
      }

      if (password.length < 8) {
        print('Password should be at least 8 characters');
        return;
      }

      if (password != confirmPassword) {
        print('Passwords do not match');
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // Store additional user data in Firestore
        await _firestore.collection('buyers').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        print('Failed to create user');
        // Handle user creation failure
      }
    } catch (e) {
      print('Sign Up Error: $e');
      // Handle sign up error
    }
  }
}
