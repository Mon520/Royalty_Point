import 'package:flutter/material.dart';
import 'package:royalty_point/constants.dart';
import 'package:royalty_point/firebase_services.dart';

class CustomerView extends StatefulWidget {
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices = FirebaseServices();
    dynamic currentUser;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: _firebaseServices.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              currentUser = snapshot.data;
              return Card(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Text(
                            currentUser['name'],
                            textAlign: TextAlign.start,
                            style: kNameStyle,
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title:
                                Text(currentUser['email'], style: kLabelStyle),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_view_day),
                            title: Text(currentUser['dob'], style: kLabelStyle),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(currentUser['phoneNum'],
                                style: kLabelStyle),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_city),
                            title: Text(currentUser['address'],
                                style: kLabelStyle),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                              color: Colors.deepPurpleAccent, width: 2)),
                      elevation: 7.0,
                      child: Row(
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(currentUser['point'].toString(),
                              style: TextStyle(fontSize: 150.0)),
                          Text('Points', style: TextStyle(fontSize: 50.0))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('No Data');
            }
          }),
    );
  }
}
