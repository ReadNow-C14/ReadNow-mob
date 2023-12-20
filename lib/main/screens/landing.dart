import 'package:flutter/material.dart';
import 'package:readnow_mobile/main/login.dart';
import 'package:readnow_mobile/main/register.dart';
import 'package:readnow_mobile/styles/colors.dart';

void main() {
  runApp(const LandingPage());
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          // Use Stack to overlay the darkening container
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
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
                  const Expanded(
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colorz.yellow, // Button color
                              foregroundColor: Colorz.black,
                              //textStyle:  // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 10),
                              elevation: 5,
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        // Sign Up button
                        const SizedBox(height: 20),
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colorz.blue, // Button color
                              foregroundColor: Colorz.black,
                              //textStyle:  // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 10),
                              elevation: 5,
                            ),
                            child: const Text('Sign Up'),
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
                        const SizedBox(height: 100),
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
