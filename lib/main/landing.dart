import 'package:flutter/material.dart';
import 'package:readnow_mobile/main/login.dart';
import 'package:readnow_mobile/main/register.dart';
import 'package:readnow_mobile/styles/colors.dart';

class LandingApp extends StatelessWidget {
  const LandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          // Use Stack to overlay the darkening container
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/landing.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              // This container is the semi-transparent overlay
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Darken the background
              ),
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(), // Empty container used for spacing
                  ),
                  // Positioned text at the top
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ReadNow',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                        /*Text(
                          'ReadNow',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white, // Text color
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  // Positioned buttons at the bottom
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          // Login button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                              );
                            },
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colorz.yellow, // Button color
                              foregroundColor: Colorz.black,
                              //textStyle:  // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 10),
                              elevation: 5,
                            ),
                          ),
                        ),
                        // Sign Up button
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const RegisterPage();
                                  },
                                ),
                              );
                            },
                            child: Text('Sign Up'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colorz.blue, // Button color
                              foregroundColor: Colorz.black,
                              //textStyle:  // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 10),
                              elevation: 5,
                            ),
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextButton(
                            onPressed: () {},
                            child: Text('SKIP >',
                                style: TextStyle(color: Colorz.white)),
                          ),
                        ),*/
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
