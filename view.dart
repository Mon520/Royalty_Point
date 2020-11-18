import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:royalty_point/firebase_services.dart';
import 'package:royalty_point/screens/customer_view.dart';
import 'package:royalty_point/screens/merchant_view.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userType;
  dynamic user;

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
    _firebaseServices.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Royalty Point',
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.person,
              ),
              onPressed: () async {
                _auth.signOut();
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _firebaseServices.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data;
              userType = user['userType'];
              return userType == 'merchant' ? MerchantView() : CustomerView();
            } else {
              return Text('No Data');
            }
          },
        ));
  }
}
