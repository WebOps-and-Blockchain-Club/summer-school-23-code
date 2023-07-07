import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

Widget Email() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Text(
          'Email',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Center(
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(43, 52, 103, 1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          width: 360,
          height: 56,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10),
                prefixIcon: Icon(Icons.email)),
          ),
        ),
      )
    ],
  );
}

Widget Pass() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Center(
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(43, 52, 103, 1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          width: 360,
          height: 56,
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10),
                prefixIcon: Icon(Icons.person)),
          ),
        ),
      )
    ],
  );
}

Widget LoginButton() {
  return Center(
    child: Container(
      width: 100,
      height: 40,
      child: ElevatedButton(
        child: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        onPressed: () {},
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
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 186, 215, 233),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/loginImage.jpg',
                    width: double.infinity,
                    height: 252,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Email(),
                  SizedBox(
                    height: 5,
                  ),
                  Pass(),
                  SizedBox(height: 30),
                  LoginButton(),
                  Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Text(
                          "Don't have a account ?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
