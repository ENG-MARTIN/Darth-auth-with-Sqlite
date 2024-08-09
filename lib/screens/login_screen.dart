import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:auth_demo/db_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    print("LoginScreen: Attempting to login with username: $username");

    var user = await _databaseHelper.getUser(username, password);
    if (user != null) {
      print("LoginScreen: Login successful");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login successful!"),
      ));
      // Navigate to home screen or dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print("LoginScreen: Login failed - Invalid username or password");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid username or password."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
                print("LoginScreen: Login button pressed");
                _login();
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                print("LoginScreen: Signup button pressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
