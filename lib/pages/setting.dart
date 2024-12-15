
import 'package:flick/pages/register_screen.dart';
import 'package:flick/pages/selectplan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notificationpage.dart';

class MyPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile_picture.jpg'), // Replace with your image asset
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 15,
                    color: Colors.blue, // Set the background color
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Rohit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 65, 64, 64),
                  borderRadius: BorderRadius.circular(30), // Rounded border
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5, // Add shadow
                          padding:
                              const EdgeInsets.all(15), // Increase button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                40), // Rounded border for the button
                          ),
                          minimumSize: const Size(300, 65),
                          backgroundColor:
                              const Color.fromRGBO(205, 205, 205, 1)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'My Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                             builder: (context) => const NotificationPage(),
                            ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: const Size(300, 65),
                          backgroundColor:
                              const Color.fromRGBO(205, 205, 205, 1)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.notifications_active,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Notification',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                              Navigator.push(
                          context,
                          MaterialPageRoute(
                             builder: (context) => const SelectPlan(),
                            ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: const Size(300, 65),
                          backgroundColor:
                              const Color.fromRGBO(205, 205, 205, 1)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Subscribe',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Close the app
                        SystemNavigator.pop();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          padding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: const Size(300, 65),
                          backgroundColor:
                              const Color.fromRGBO(205, 205, 205, 1)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Log out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountPage {
  const AccountPage();
}

class SettingPage {
  const SettingPage();
}
