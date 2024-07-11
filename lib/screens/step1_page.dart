import 'package:cineflix/components/custom_button.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/start_screen.dart';
import 'package:cineflix/screens/step2_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Step1 extends StatefulWidget {
  final String email;
  const Step1({super.key, required this.email});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          height: 500,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 150,
                  width: 300,
                  child: Image.asset("assets/devices.png")),
              Text(
                "STEP 1 OF 3",
                textAlign: TextAlign.center,
              ),
              Text(
                "Finish setting up your",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "account",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Netflix is personalized for you.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "Create a password to watch on any",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              Text(
                "device at any time.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 350,
                  height: 60,
                  child: CustomButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Step2(
                                    email: widget.email,
                                  )));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
