import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String message = '';

  Future<void> signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();

    final response = await http.post(
      Uri.parse('http://localhost:9191/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'fname': firstName,
        'lname': lastName,
      }),
    );

    setState(() {
      if (response.statusCode == 200) {
        message = 'User registered successfully';
      } else if (response.statusCode == 409) {
        message = 'User with this email already exists';
      } else {
        message = 'Failed to register user: ${response.body}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
