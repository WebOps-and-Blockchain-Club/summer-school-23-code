import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './signUp.dart';

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

Widget SignButton() {
  return Center(
    child: Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        child: Text(
          "Sign Up",
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

Widget CustomTextField(String label, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 30),
        child: Text(
          '$label',
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
          width: width,
          height: 56,
          child: TextField(
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      )
    ],
  );
}

class _NewUserFormState extends State<NewUserForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(50),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 186, 215, 233),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "New Account",
                          style: TextStyle(
                              color: Color.fromARGB(230, 43, 52, 103),
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(1, 0, 0, 0),
                                ),
                              ]),
                        ),
                        Text(
                          "Sign Up and get started",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(1, 0, 0, 0),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Email(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: CustomTextField('First Name', 143),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: CustomTextField('Last Name', 143),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField('Meta-Mask Id', 360),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField('Roll', 360),
                  SizedBox(
                    height: 10,
                  ),
                  Pass(),
                  SizedBox(
                    height: 20,
                  ),
                  SignButton(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
