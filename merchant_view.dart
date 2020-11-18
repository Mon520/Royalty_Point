import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:royalty_point/screens/view_detail.dart';

class MerchantView extends StatefulWidget {
  @override
  _MerchantViewState createState() => _MerchantViewState();
}

class _MerchantViewState extends State<MerchantView> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String userId;

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .where('userType', isEqualTo: 'customer')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot customers = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    userId = customers.id;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewDetail(
                                  userId: userId,
                                )));
                  },
                  child: ListTile(
                    leading: Text(customers['name']),
                    trailing: Text(customers['point'].toString()),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
