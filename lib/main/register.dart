import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readnow_mobile/main/login.dart';
import 'package:readnow_mobile/styles/colors.dart';
import 'package:readnow_mobile/styles/fonts.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _passwordVisible = false;

  Future<void> registerUser() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/auth/register/'),
        body: {
          'username': username,
          'password': password,
        },
      );

      // Check if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final result = json.decode(response.body);
        if (response.statusCode == 201) {
          // Handle successful registration
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Successful'),
              content: Text(result['message']),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss dialog
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          // Handle other statuses
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Failed'),
              content: Text(result['message'] ?? 'Unknown error'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Dismiss dialog
                  },
                ),
              ],
            ),
          );
        }
      } else {
        // The response is not JSON. Likely an HTML error page.
        print(response.body);
        print(response.statusCode);
        throw Exception('Received invalid response format from the server');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: SingleChildScrollView(
            child: Text(
              'An error occurred: ${e.toString()}',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Dismiss dialog
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colorz.black),
          onPressed: () => Navigator.of(context).pop(),
        ),*/
        backgroundColor: Colorz.blue,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colorz.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colorz.blue,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign up',
              style: Fontz.B70,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 8.0),
            Text(
              'Create account',
              style: Fontz.M17,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 48.0),
            Stack(
              clipBehavior: Clip.none, // Allow overflow
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  decoration: BoxDecoration(
                    color: Colorz.bluewhite,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
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
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordConfirmationController,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          hintText: 'Confirm password',
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
                      SizedBox(height: 20.0), // Space for half of the button
                    ],
                  ),
                ),
                Positioned(
                  top:
                      300, // Adjust this value to position the button correctly
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      child: Text('Sign up'),
                      onPressed: () {
                        registerUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorz.yellow, // Button color
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
