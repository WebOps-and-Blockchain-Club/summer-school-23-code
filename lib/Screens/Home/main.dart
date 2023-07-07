import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './card.dart';
import './drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class Event {
  late String Title;
  late String Content;
  late String Date;
  Event(String Title, String Content, String Date) {
    this.Title = Title;
    this.Content = Content;
    this.Date = Date;
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final EventList = [
      Event('Hey', 'Content', 'Date'),
      Event('Hey', 'Content', 'Date'),
      Event('Hey', 'Content', 'Date'),
      Event('Hey', 'Content', 'Date')
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: CustomDrawer(context),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(43, 52, 103, 1),
          title: Center(
            child: Text(
              'Summer-School',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: EventList.length,
          itemBuilder: (context, index) {
            return CustomCard(
              postContent: EventList[index].Content,
              postDate: EventList[index].Date,
              postTitle: EventList[index].Title,
            );
          },
        ));
  }
}
