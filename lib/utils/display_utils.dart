import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}