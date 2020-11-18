import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:royalty_point/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.deepPurpleAccent,
        primaryColor: Colors.deepPurpleAccent,
        //scaffoldBackgroundColor: Colors.indigo[200],
      ),
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
