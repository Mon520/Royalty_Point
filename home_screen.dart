import 'package:flutter/material.dart';
import 'package:royalty_point/button.dart';
import 'package:royalty_point/screens/log_in_screen.dart';
import 'package:royalty_point/screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Royalty Point',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              Button(
                title: 'Log In',
                onPressed: () {
                  print('Log In Pressed');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Button(
                title: 'Register',
                onPressed: () {
                  print('Register Pressed');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
