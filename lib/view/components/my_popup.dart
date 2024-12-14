import 'package:flutter/material.dart';

//display error messaje to user
void MyPopup(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    )
  );
}