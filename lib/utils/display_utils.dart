import 'package:flutter/material.dart';

class DisplayUtils {
  static showAlert(BuildContext context, String title, String message, Function() okPressedListener, { bool isDismissible = true }) {
    Widget okButton = TextButton(
      child: const Text("OK",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: () => okPressedListener,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: isDismissible,
    );
  }
}