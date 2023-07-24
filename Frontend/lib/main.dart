import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_school_23_code/Screens/Profile/profile.dart';
import 'package:summer_school_23_code/Services/contract.dart';
import 'package:summer_school_23_code/themes.dart';
import 'Screens/Login/login.dart';
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
    return ChangeNotifierProvider(
      create: (_) => Contract(),
      child: MaterialApp(
          title: 'Flutter Demo', theme: Themes.theme, home: Login()),
    );
  }
}
