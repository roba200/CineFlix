import 'dart:convert';

import 'package:cineflix/Model/User.dart';
import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/components/custom_textfield.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/homepage.dart';
import 'package:cineflix/screens/start_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Step2 extends StatefulWidget {
  final String email;
  Step2({super.key, required this.email});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String error = "";
  bool isHover = false;
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
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }), (route) => false);
        User user = User.fromJson(jsonDecode(response.body));
        print(user.email);
        print('User registered successfully');
        error = "";
      } else if (response.statusCode == 409) {
        print('User with this email already exists');
        error = 'User with this email already exists';
      } else {
        print('Failed to register user: ${response.body}');
        error = 'Failed to register user: ${response.body}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: grey,
              height: 1.0,
            )),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StartScreen()));
            },
            onHover: (value) {
              setState(() {
                isHover = value;
              });
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration:
                      isHover ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: black),
            ),
          ),
          SizedBox(
            width: 100,
          ),
        ],
        leadingWidth: 400,
        toolbarHeight: 100,
        elevation: 0,
        leading: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/logo.png"))),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 600,
          width: 500,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "STEP 2 OF 3",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Create a password to start",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  "your membership",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Just a few more steps and you're done!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "We hate paperwork, too.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: firstNameController,
                  baseColor: black,
                  text: 'First name',
                  validator: (fname) =>
                      fname.toString().isEmpty || fname == null
                          ? 'This field is required'
                          : null,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: lastNameController,
                  baseColor: black,
                  text: 'Last name',
                  validator: (lname) =>
                      lname.toString().isEmpty || lname == null
                          ? 'This field is required'
                          : null,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: emailController,
                  baseColor: black,
                  text: 'Email',
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  controller: passwordController,
                  baseColor: black,
                  text: 'Add a password',
                  validator: (password) {
                    if (password.toString().length < 6 || password == null) {
                      return 'Password must be at least 6 charactors';
                    } else {
                      return null;
                    }
                  },
                  obsecureText: true,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(error),
                SizedBox(
                    width: 500,
                    height: 60,
                    child: CustomButton(
                      text: 'Next',
                      onPressed: () async {
                        final form = formKey.currentState!;
                        if (form.validate()) {
                          await signUp();
                        } else {
                          setState(() {
                            error = "";
                          });
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
