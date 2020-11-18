import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:royalty_point/button.dart';
import 'package:royalty_point/constants.dart';
import 'package:royalty_point/view.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _phoneNumController = TextEditingController();

  String name;
  String email;
  String address;
  String dob;
  String password;
  String shopName;
  String userType;
  String phoneNum;
  int point;
  String errorMsg = '';

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  bool merchantVisibility = false;
  String dropdownValue = "Customer";
  bool customerVisibility = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Registration',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 40),
                  ),
                ),
                SizedBox(height: 10.0),
                new DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      if (newValue == "Customer") {
                        customerVisibility = true;
                        merchantVisibility = false;
                      } else {
                        merchantVisibility = true;
                        customerVisibility = false;
                      }
                    });
                  },
                  items: <String>['Customer', 'Merchant']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name Cannot Be Empty!';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: kRegisterinputDecoration.copyWith(
                      labelText: 'Enter Name'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please Enter Email Again!';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: kRegisterinputDecoration.copyWith(
                      labelText: 'Enter Email'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password Cannot Be Empty!';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: _passwordController,
                  decoration: kRegisterinputDecoration.copyWith(
                      labelText: 'Enter Password'),
                ),
                SizedBox(height: 10.0),
                Visibility(
                  visible: merchantVisibility,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Shop Name Cannot Be Empty!';
                      }
                      return null;
                    },
                    controller: _shopNameController,
                    decoration: kRegisterinputDecoration.copyWith(
                        labelText: 'Enter Shop Name'),
                  ),
                ),
                Visibility(
                  visible: customerVisibility,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Date Of Birth Cannot Be Empty!';
                      }
                      return null;
                    },
                    controller: _dobController,
                    decoration: kRegisterinputDecoration.copyWith(
                        labelText: 'Enter Date of Birth'),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone Number Cannot Be Empty!';
                    }
                    return null;
                  },
                  controller: _phoneNumController,
                  decoration: kRegisterinputDecoration.copyWith(
                      labelText: 'Enter Phone Number'),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Address Cannot Be Empty!';
                    }
                    return null;
                  },
                  controller: _addressController,
                  decoration: kRegisterinputDecoration.copyWith(
                      labelText: 'Enter Address'),
                ),
                errorMsg.isEmpty ? Text('') : Text(errorMsg),
                SizedBox(
                  height: 20.0,
                ),
                Button(
                    title: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        name = _nameController.text;
                        address = _addressController.text;
                        email = _emailController.text;
                        phoneNum = _phoneNumController.text;
                        password = _passwordController.text;
                        if (customerVisibility) {
                          dob = _dobController.text;
                          userType = 'customer';
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            var firebaseUser =
                                FirebaseAuth.instance.currentUser;
                            if (newUser != null) {
                              _firestore
                                  .collection('users')
                                  .doc(firebaseUser.uid)
                                  .set({
                                'userType': userType,
                                'name': name,
                                'address': address,
                                'dob': dob,
                                'phoneNum': phoneNum,
                                'email': email,
                                'point': 0,
                              }).then((_) {
                                print('success');
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => View()));
                            }
                          } on PlatformException catch (e) {
                            if (e.message ==
                                'The email address is already in use by another account.') {
                              setState(() {
                                errorMsg = e.message;
                              });
                            }
                          }
                        }
                      } else if (merchantVisibility) {
                        shopName = _shopNameController.text;
                        userType = 'merchant';
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          if (newUser != null) {
                            _firestore
                                .collection('users')
                                .doc(firebaseUser.uid)
                                .set({
                              'userType': userType,
                              'name': name,
                              'address': address,
                              'phoneNum': phoneNum,
                              'shopName': shopName,
                              'email': email,
                            }).then((_) {
                              print('success');
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => View()));
                          }
                        } on PlatformException catch (e) {
                          if (e.message ==
                              'The email address is already in use by another account.') {
                            setState(() {
                              errorMsg = e.message;
                            });
                          }
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
