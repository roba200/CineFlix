import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/components/custom_textfield.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/signin_page.dart';
import 'package:cineflix/screens/step1_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfields/textfields.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            child: Text(
              "Sign In",
              style: TextStyle(color: Color.fromARGB(255, 252, 249, 255)),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 9, 20),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
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
        child: Container(
          height: 500,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Unlimited movies, TV shows, and more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 249, 255),
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Watch anywhere. Cancel anytime.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 252, 249, 255),
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Ready to watch? Enter your email to create or restart your membership.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 252, 249, 255),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: SizedBox(
                        width: 400,
                        child: CustomTextField(
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                          controller: emailController,
                          baseColor: white,
                          text: 'Email address',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                          height: 60,
                          child: CustomButton(
                            text: 'Get Started >',
                            onPressed: () {
                              final form = formKey.currentState!;
                              if (form.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Step1(
                                              email: emailController.text,
                                            )));
                              }
                            },
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
