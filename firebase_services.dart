import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic user;

  Future getCurrentUser() async {
    User loggedInUser;
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        loggedInUser = currentUser;
        await _firestore
            .collection('users')
            .doc(loggedInUser.uid)
            .get()
            .then((value) {
          user = value.data();
        });
        return await user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getDetails(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).get().then((value) {
        user = value.data();
      });
      return await user;
    } catch (e) {
      print(e);
    }
  }
}
