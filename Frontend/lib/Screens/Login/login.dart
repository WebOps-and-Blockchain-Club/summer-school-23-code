import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:summer_school_23_code/Screens/Home/main.dart';
import 'package:http/http.dart' as http;
import 'package:summer_school_23_code/Screens/Login/newUser.dart';
import 'package:web3dart/web3dart.dart';

TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();

final LocalStorage storage = LocalStorage('data');

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

void handleLogin(BuildContext context) {
  Map<String, String> body = {
    "email": email.text,
    "password": pass.text,
  };
  http.post(Uri.parse('http://localhost:8000/login'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'}).then((value) async {
    final Map<String, dynamic> data = json.decode(value.body);

    if (data["auth"] == null)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["result"]),
      ));
    else {
      print(data["auth"]);
      await storage.setItem("token", data["auth"]);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }).catchError((e) => print(e));
}

Widget Email(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 30),
        child: const Text(
          'Email',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Center(
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(43, 52, 103, 1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          width: 360,
          height: 56,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10),
                prefixIcon: Icon(Icons.email)),
          ),
        ),
      )
    ],
  );
}

Widget Pass(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 30),
        child: const Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Center(
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                  color: Color.fromRGBO(43, 52, 103, 1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          width: 360,
          height: 56,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10),
                prefixIcon: Icon(Icons.person)),
          ),
        ),
      )
    ],
  );
}

Widget LoginButton(context) {
  return Center(
    child: Container(
      width: 100,
      height: 40,
      child: ElevatedButton(
        child: const Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        onPressed: () => handleLogin(context),
      ),
    ),
  );
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 186, 215, 233),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                      image: AssetImage('assets/loginImage.jpg'),
                      fit: BoxFit.fitWidth),
                  const SizedBox(
                    height: 50,
                  ),
                  Email(email),
                  const SizedBox(
                    height: 5,
                  ),
                  Pass(pass),
                  const SizedBox(height: 30),
                  LoginButton(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have a account ?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewUserForm())),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
