import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0
                ),
              ),
              const SizedBox(height: 26),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password'
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 45.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )
                    ),
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter both username and password.'),
                          ),
                        );
                        return;
                      }

                      Provider.of<LoginViewModel>(context, listen: false).login(email, password).then((value) => {
                        if (value != null) {
                          if (value.data != null) {
                            Navigator.pop(context)
                          } else if (value.errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(value.errorMessage ?? 'Something wrong'),
                            ))
                          }
                        }
                      });
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
