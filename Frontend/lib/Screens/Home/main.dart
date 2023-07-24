import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:summer_school_23_code/Models/user.dart';
import 'package:summer_school_23_code/Screens/Login/newUser.dart';
import 'package:http/http.dart' as http;
import 'package:summer_school_23_code/Services/contract.dart';
import './card.dart';
import './drawer.dart';
import 'package:web3dart/web3dart.dart';

final LocalStorage storage = LocalStorage('data');

TextEditingController name = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController exp_date = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> EventList = [];
  User? user;

  getMe() async {
    final token = await storage.getItem("token");
    try {
      var data = await http.get(Uri.parse("http://localhost:8000/user/$token"));
      final body = jsonDecode(data.body);
      setState(() {
        user = User(
            user_id: body["user_id"],
            name: body["name"],
            email: body["email"],
            role: body["role"],
            metamaskId: body["meta_mask_id"]);
      });
    } catch (error) {
      print(error);
    }
  }

  getEvents() {
    http.get(Uri.parse('http://localhost:8000/events')).then((value) {
      print(value.body);
      setState(() {
        EventList = jsonDecode(value.body);
      });
    });
  }

  handleSubmit() async {
    Map<String, dynamic> data = {
      "name": name.text,
      "description": description.text,
      "date": date.text,
      "exp_date": exp_date.text,
      "user_id": user?.user_id,
      "is_valid": true
    };
    http.post(Uri.parse("http://localhost:8000/events/${user?.user_id}"),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}).then((value) {
      Navigator.of(context).pop();
      getEvents();
    });
  }

  @override
  void initState() {
    getMe();
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
            event_id: BigInt.from(EventList[index]['event_id']),
            postContent: EventList[index]['description'],
            postDate: EventList[index]['date'],
            postTitle: EventList[index]['name'],
          );
        },
      ),
      floatingActionButton: user?.role == "ORGANIZER"
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
          CustomTextField("Tile", 360, name),
          CustomTextField("Description", 360, description),
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
