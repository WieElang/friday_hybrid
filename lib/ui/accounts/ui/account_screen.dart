import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/utils/api_response_utils.dart';
import 'package:friday_hybrid/ui/accounts/viewModel/account_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/local/schemas.dart';
import '../../login/ui/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    Provider.of<AccountViewModel>(context, listen: false).setUser();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<AccountViewModel>(context, listen: false).setUser();
    }
  }

  void _onLogoutPressed() {
    Provider.of<AccountViewModel>(context, listen: false).logout().then((value) => {
      if (value != null) {
        if (value.data != null || value.exception is SessionException) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen())
          )
        } else if (value.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.errorMessage ?? 'Something wrong'),
          ))
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AccountViewModel>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.name ?? 'Unknown'),
                            const SizedBox(height: 8),
                            Text(user?.email ?? 'Unknown')
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),
            Container(
              width: double.infinity,
              height: 45.0,
              margin: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
              child: ElevatedButton(
                child: const Text("Logout"),
                onPressed: () => _onLogoutPressed(),
              ),
            )
          ],
        ),
      )
    );
  }
}
