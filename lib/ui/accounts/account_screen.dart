import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  void _onLogoutPressed() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Card(
              child: Row(
                children: [
                  Icon(Icons.account_circle),
                  Column(
                    children: [
                      Text('Name'),
                      Text('Email')
                    ],
                  )
                ],
              ),
            ),
            MaterialButton(
              child: const Text("Logout"),
              onPressed: () => _onLogoutPressed(),
            )
          ],
        ),
      )
    );
  }
}
