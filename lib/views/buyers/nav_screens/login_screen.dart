import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:island_goods/views/buyers/main_screen.dart';
import 'package:island_goods/views/buyers/nav_screens/admin_panel.dart';
import 'widgets/signup_screen.dart';

class Login extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _loginUser(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text;

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        if (email == 'sys@admin.com' && password == 'sysadmin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPanel()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      } else {
        print('Invalid email or password');
        // Handle invalid email or password
      }
    } catch (e) {
      print('Login Error: $e');
      // Handle login error
    }
  }

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
                            "Login",
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
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email or Phone number",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
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
                            _loginUser(context);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Text(
                              "Login",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Not a member? Sign Up",
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
}
