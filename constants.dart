import 'package:flutter/material.dart';

var kButtonColor = Colors.deepPurpleAccent;

var kButtonShape = RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.black),
);

var kLabelStyle = TextStyle(
  fontSize: 25.0,
);

var kNameStyle = TextStyle(
  fontSize: 70.0,
  fontWeight: FontWeight.w400,
);

var kRegisterinputDecoration = InputDecoration(
  labelText: 'Enter label',
  labelStyle: TextStyle(color: Colors.deepPurpleAccent),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: Colors.purpleAccent,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: Colors.purple),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: Colors.red)),
);
