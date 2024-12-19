import 'package:flutter/material.dart';

void RecDialog(String message, BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is a typical dialog.'),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    )
  );
}