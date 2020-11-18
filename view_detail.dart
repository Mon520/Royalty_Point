import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:royalty_point/constants.dart';
import 'package:royalty_point/firebase_services.dart';

class ViewDetail extends StatefulWidget {
  final String userId;
  ViewDetail({this.userId});

  @override
  _ViewDetailState createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseServices _firebaseServices = FirebaseServices();
  dynamic user;
  int point;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Royalty Point',
            textAlign: TextAlign.center,
          ),
        ),
        body: FutureBuilder(
          future: _firebaseServices.getDetails(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data;
              point = user['point'];
              return Card(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Text(
                            user['name'],
                            textAlign: TextAlign.start,
                            style: kNameStyle,
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(user['email'], style: kLabelStyle),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_view_day),
                            title: Text(
                              user['dob'],
                              style: kLabelStyle,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              user['phoneNum'],
                              style: kLabelStyle,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_city),
                            title: Text(user['address'], style: kLabelStyle),
                          ),
                          Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                      color: Colors.deepPurpleAccent,
                                      width: 2)),
                              elevation: 7.0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(user['point'].toString(),
                                          style: TextStyle(fontSize: 80.0)),
                                      Text('Points',
                                          style: TextStyle(fontSize: 30.0))
                                    ],
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        point++;
                                        _firestore
                                            .collection("users")
                                            .doc(widget.userId)
                                            .update({"point": point}).then((_) {
                                          print("success!");
                                        });
                                      });
                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.deepPurpleAccent,
                                    child: Icon(
                                      Icons.add,
                                      size: 50.0,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
