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
              Image.asset('assets/images/friday_logo.png',
                width: 40.0,
                height: 53.0,
                fit: BoxFit.cover
              ),
              const SizedBox(
                height: 14.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                      fontSize: 20.0
                    ),
                  ),
                  Text(
                    'Friday',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.orange
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.grey
                    )
                  ),
                  labelText: 'Email',
                ),
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _passwordController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey
                        )
                    ),
                  labelText: 'Password'
                ),
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 45.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
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
                          fontSize: 14.0
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
