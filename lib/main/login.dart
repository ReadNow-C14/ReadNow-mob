// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readnow_mobile/main/widgets/bottom_nav.dart';
import 'package:readnow_mobile/styles/colors.dart';
import 'package:readnow_mobile/styles/fonts.dart';
import 'package:readnow_mobile/main/register.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colorz.black),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
        backgroundColor: Colorz.yellow,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                color: Colorz.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colorz.yellow,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 100), // Add padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Login',
              style: Fontz.B70,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            Text(
              'Welcome to ReadNow',
              style: Fontz.M17,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 48.0),
            Stack(
              clipBehavior: Clip.none, // Allow overflow
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 40.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colorz.warmwhite, // Change container color to yellow
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter username',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              // change the icon based on the password visibility
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // password visibility state
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_passwordVisible,
                      ),
                      SizedBox(height: 24.0), // Space for the button
                    ],
                  ),
                ),
                Positioned(
                  top:
                      220, // Adjust this value to position the button correctly
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        // Cek kredensial
                        final response = await request.login(
                            "https://readnow-c14-tk.pbp.cs.ui.ac.id/auth/login/",
                            {
                              'username': username,
                              'password': password,
                            });

                        if (request.loggedIn) {
                          String message = response['message'];
                          String uname = response['username'];
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => BottomNav()),
                              (route) => false);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text("$message Welcome, $uname.")));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Failed'),
                              content: Text(response['message']),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorz.blue, // Button color
                        foregroundColor: Colorz.black,
                        textStyle: Fontz.B17, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 10),
                        elevation: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
