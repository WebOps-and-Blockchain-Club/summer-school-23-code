import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Models/event.dart';
import './card.dart';
import './drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final EventList = [
      Event(
          'Hey',
          'Content ieuynhr4cik3gy rbiwkeruygf ikyefrgf oqlrgwf qlauiwgef o gwe fk  ywefg u ewygf oqegwrf uqyrgf ',
          'Date'),
      Event('Hey', 'Content', 'Date'),
      Event('Hey', 'Content', 'Date'),
      Event('Hey', 'Content', 'Date')
    ];
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
              postContent: EventList[index].Content,
              postDate: EventList[index].Date,
              postTitle: EventList[index].Title,
            );
          },
        ));
  }
}
