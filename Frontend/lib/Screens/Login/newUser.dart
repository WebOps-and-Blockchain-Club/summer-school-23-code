import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:summer_school_23_code/Screens/Home/main.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController metaMask = TextEditingController();

final LocalStorage storage = LocalStorage('data');

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

void handleSignUp(BuildContext context, String role) {
  Map<String, String> body = {
    "name": name.text,
    "email": email.text,
    "password": pass.text,
    "meta_mask_id": metaMask.text,
    "role": role
  };
  http.post(Uri.parse('http://localhost:8000/registration'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'}).then((value) async {
    print(value.body);
    final Map<String, dynamic> data = json.decode(value.body);
    if (data["auth"] == null)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["result"]),
      ));
    else {
      await storage.setItem("values", {"token": data["auth"]});
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }).catchError((error) => print(error));
}

Widget SignButton(BuildContext context, String role) {
  return Center(
    child: Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        onPressed: () => handleSignUp(context, role),
      ),
    ),
  );
}

Widget CustomTextField(
    String label, double width, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 30),
        child: Text(
          '$label',
          style: const TextStyle(
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
          width: width,
          height: 56,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      )
    ],
  );
}

class _NewUserFormState extends State<NewUserForm> {
  String role = "USER";
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
                    padding: const EdgeInsets.all(50),
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 215, 233),
                    ),
                    child: const Column(
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
                  const SizedBox(
                    height: 30,
                  ),
                  Email(email),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField('Name', 360, name),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField('Meta-Mask Id', 360, metaMask),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        'Role : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'USER',
                            groupValue: role,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) role = value;
                              });
                            },
                          ),
                          const Text('USER',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'ORGANIZER',
                            groupValue: role,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) role = value;
                              });
                            },
                          ),
                          const Text(
                            'ORGANIZER',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Pass(pass),
                  const SizedBox(
                    height: 20,
                  ),
                  SignButton(context, role),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}
