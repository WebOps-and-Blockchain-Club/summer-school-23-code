import 'package:flutter/material.dart';
import 'package:summer_school_23_code/Screens/Profile/profile.dart';

Widget CustomDrawer(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            padding: EdgeInsets.all(0),
            child: Image.asset(
              'assets/DrawerImage.jpg',
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: const Text('Your Tickets'),
            onTap: () {
              // Update the state of the app

              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: const Text('About Us'),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
