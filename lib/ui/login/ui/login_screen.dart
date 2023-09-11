import 'package:flutter/material.dart';
import 'package:friday_hybrid/data/remote/api_response.dart';
import 'package:friday_hybrid/data/remote/models/auth_api_model.dart';
import 'package:friday_hybrid/ui/login/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider.of<LoginViewModel>(context, listen: false).loginResponse;
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse<LoginApiModel> loginResponse = Provider.of<LoginViewModel>(context).loginResponse;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password'
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    // Replace this with your authentication logic
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      // Perform authentication here (e.g., check against a database)
                      // For this example, we will just print the credentials.

                      print('Email: $email');
                      print('Password: $password');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter both username and password.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      )
    );
  }
}
