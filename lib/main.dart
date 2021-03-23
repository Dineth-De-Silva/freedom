import 'package:firebase_core/firebase_core.dart';
import 'package:freedom/constants.dart';
import 'package:flutter/material.dart';
import 'package:freedom/screens/welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Freedom());
}

class Freedom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freedom',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        iconTheme: IconThemeData(color: kContentColorLightTheme),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor,
        ),
      ),
      home: Welcome(),
    );
  }
}
