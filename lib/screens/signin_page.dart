import 'dart:convert';

import 'package:cineflix/Model/User.dart';
import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/components/custom_textfield.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/homepage.dart';
import 'package:cineflix/screens/start_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hover = false;
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final response = await http.post(
      Uri.parse('http://localhost:9191/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    setState(() {
      if (response.statusCode == 200) {
        print('User logged successfully');
        User user = User.fromJson(jsonDecode(response.body));
        print(user.email);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const HomePage();
        }), (route) => false);
      } else if (response.statusCode == 401) {
        print('User Unauthorized');
      } else {
        print('Failed to login user: ${response.body}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
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
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/backdrop.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.colorBurn),
        )),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/black.png"),
              fit: BoxFit.fill,
              opacity: 0.4,
            )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 35,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        width: 300,
                        child: CustomTextField(
                          controller: emailController,
                          baseColor: white,
                          text: 'Email',
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: 300,
                        child: CustomTextField(
                          controller: passwordController,
                          baseColor: white,
                          text: 'Password',
                          obsecureText: true,
                          validator: (password) {
                            if (password.toString().length < 6 ||
                                password == null) {
                              return 'Password must be at least 6 charactors';
                            } else {
                              return null;
                            }
                          },
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: CustomButton(
                          text: 'Sign In',
                          onPressed: () async {
                            final form = formKey.currentState!;
                            if (form.validate()) {
                              print("sign in");
                              await login();
                            }
                          },
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "New to Netflix?",
                          style: TextStyle(color: grey),
                        ),
                        TextButton(
                            onHover: (value) {
                              setState(() {
                                hover = value;
                              });
                            },
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartScreen()));
                            },
                            child: Text(
                              "Sign up now.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                  decoration: hover
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  decorationColor: white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
