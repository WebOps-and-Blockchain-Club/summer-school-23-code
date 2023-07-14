import 'package:flutter/material.dart';
import 'package:summer_school_23_code/Screens/Profile/profile.dart';
import 'package:summer_school_23_code/themes.dart';
import 'Screens/Login/signUp.dart';
import 'Screens/Login/newUser.dart';
import 'Screens/Home/card.dart';
import 'Screens/Home/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: Themes.theme, home: NewUserForm());
  }
}
