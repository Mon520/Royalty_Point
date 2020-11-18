import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:royalty_point/button.dart';
import 'package:royalty_point/view.dart';

// ignore: must_be_immutable
class LogInScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email;
  String password;

  final _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: Form(
                key: _loginFormKey,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                            child: Text('Log In',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(
                          height: 20.0,
                        ),
                        LogInTextForm(
                          title: 'Email',
                          controller: _emailController,
                          isObsecure: false,
                        ),
                        SizedBox(height: 20.0),
                        LogInTextForm(
                          title: 'Password',
                          controller: _passwordController,
                          isObsecure: true,
                        ),
                        SizedBox(height: 50.0),
                        Button(
                            title: 'Log In',
                            onPressed: () async {
                              email = _emailController.text;
                              password = _passwordController.text;
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => View()));
                                }
                              } catch (e) {
                                switch (e.message) {
                                  case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                                    return 'User with this e-mail not found.';
                                    break;
                                  case 'The password is invalid or the user does not have a password.':
                                    return 'Invalid password.';
                                    break;
                                  case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                    return 'No internet connection.';
                                    break;
                                  case 'The email address is already in use by another account.':
                                    return 'Email address is already taken.';
                                    break;
                                  default:
                                    return 'Unknown error occured.';
                                }
                              }
                            })
                      ],
                    ),
                  ),
                ))));
  }
}

// ignore: must_be_immutable
class LogInTextForm extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isObsecure;

  bool empty;

  LogInTextForm({this.controller, this.title, this.isObsecure});

  @override
  Widget build(BuildContext context) {
    empty = title.isEmpty;
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Colors.purple),
        errorText: empty ? "$title can't be empty" : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
      ),
    );
  }
}
