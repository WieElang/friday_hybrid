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

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<AccountViewModel>(context, listen: false).setUser();
  }

  void _onLogoutPressed() {
    Provider.of<AccountViewModel>(context, listen: false).logout().then((value) => {
      if (value != null) {
        if (value.data != null || value.exception is SessionException) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen())
          ).then((value) => {
            Provider.of<AccountViewModel>(context, listen: false).setUser()
          })
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
        appBar: AppBar(
          title: const Text("Profile",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
              )
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(
                        color: Colors.orange,
                        width: 1.0
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 48.0),
                    child: Row(
                      children: [
                        const Center(child: Icon(Icons.account_circle)),
                        const SizedBox(width: 24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.employeeCode ?? '-',
                              style: const TextStyle(fontSize: 10.0),
                            ),
                            const SizedBox(height: 2.0),
                            Text(user?.name ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.orange
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(user?.email ?? 'Unknown',
                              style: const TextStyle(fontSize: 10.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: double.infinity,
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () => _onLogoutPressed(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),
                  child: const Text("Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              const Text("v1.0 (1)",
                style: TextStyle(fontSize: 10.0),
              )
            ],
          ),
        )
    );
  }
}
