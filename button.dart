import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.onPressed, this.title});
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        elevation: 4.0,
        color: Colors.deepPurpleAccent,
        child: MaterialButton(
          minWidth: 150.0,
          height: 42.0,
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
