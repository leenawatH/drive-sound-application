import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding:
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Container(),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement login functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width - 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Log In'),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement sign up functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width - 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // TODO: Implement forgot password functionality
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                child: const Text('Forget your password?'),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
