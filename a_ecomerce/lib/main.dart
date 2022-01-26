import 'package:a_ecomerce/screens/Landing_pages.dart';
import 'package:a_ecomerce/screens/login_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false ,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: Color(0xFFFF1E00)
        ),
        home: LadingPage()

    );
  }
}
