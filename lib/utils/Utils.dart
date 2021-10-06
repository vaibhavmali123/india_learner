import 'package:flutter/material.dart';

class Utils {
  static var textFieldBorder = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black38));

  static var errorHeight = TextStyle(height: 0.4);
  static var errorBorder = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red));

  static var loader = Center(
    child: CircularProgressIndicator(),
  );

  static var noData = Center(
    child: Text('No data'),
  );
}
