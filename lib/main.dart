import 'dart:convert';
import 'dart:ui';
import 'package:cineflix/components/youtube_player%20.dart';
import 'package:cineflix/constants.dart';
import 'package:cineflix/screens/homepage.dart';
import 'package:cineflix/screens/search_screen.dart';

import 'package:cineflix/screens/signin_page.dart';
import 'package:cineflix/screens/start_screen.dart';
import 'package:cineflix/screens/step1_page.dart';
import 'package:cineflix/screens/step2_page.dart';

import 'package:cineflix/signup-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_iframe_plus/youtube_player_iframe_plus.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
        //home: HomePage(),

        home: StartScreen());
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
