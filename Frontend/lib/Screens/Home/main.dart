import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:summer_school_23_code/Screens/Login/newUser.dart';
import '../../Models/event.dart';
import './card.dart';
import './drawer.dart';
import 'package:http/http.dart' as http;

final LocalStorage storage = LocalStorage('data');

TextEditingController title = TextEditingController();
TextEditingController content = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController exp_date = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> EventList = [];
  late Map<String, dynamic> local;

  String role = '';

  getRole() async {
    var r = await storage.getItem('values');
    setState(() {
      local = r;
      role = r["role"];
    });
  }

  getEvents() {
    http.get(Uri.parse('http://localhost:8000/events')).then((value) {
      setState(() {
        EventList = jsonDecode(value.body);
      });
    });
  }

  handleSubmit() async {
    var user_id = local["my_id"];
    Map<String, dynamic> data = {
      "title": title.text,
      "content": content.text,
      "date": date.text,
      "exp_date": exp_date.text,
      "user_id": user_id
    };
    http.post(Uri.parse("http://localhost:8000/events/$user_id"),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}).then((value) {
      Navigator.of(context).pop();
      getEvents();
    });
  }

  @override
  void initState() {
    getRole();
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(context),
      appBar: AppBar(
        title: const Text(
          'Summer-School',
        ),
      ),
      body: ListView.builder(
        itemCount: EventList.length,
        itemBuilder: (context, index) {
          return CustomCard(
            postContent: EventList[index]['content'],
            postDate: EventList[index]['date'],
            postTitle: EventList[index]['title'],
          );
        },
      ),
      floatingActionButton: role == "ORGANIZER"
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return createWidget();
                    });
              })
          : SizedBox.fromSize(size: Size.zero),
    );
  }

  Widget createWidget() {
    return AlertDialog(
      title: Text('Create and Event'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField("Tile", 360, title),
          CustomTextField("Description", 360, content),
          CustomTextField("Date of the Event", 360, date),
          CustomTextField("Closing Date", 360, exp_date),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: ElevatedButton(
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () => handleSubmit(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
