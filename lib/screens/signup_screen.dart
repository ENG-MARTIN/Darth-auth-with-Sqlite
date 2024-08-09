import 'package:flutter/material.dart';
import 'package:auth_demo/db_helper.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    print("SignupScreen: Attempting to register with username: $username");

    await _databaseHelper.saveUser(username, password);
    print("SignupScreen: User registered successfully");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("User registered successfully!"),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("SignupScreen: Sign Up button pressed");
                _register();
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
