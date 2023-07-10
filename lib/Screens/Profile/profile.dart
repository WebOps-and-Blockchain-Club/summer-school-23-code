import 'package:flutter/material.dart';
import 'package:summer_school_23_code/Models/user.dart';
import 'package:summer_school_23_code/Screens/Profile/editProfile.dart';
import 'package:summer_school_23_code/themes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User(
        name: "User Name",
        email: "email@gmail.com",
        role: "Organiser",
        metamaskId: "Metamask Id");
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Image(image: AssetImage('assets/backArrow.png')))),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/profileImg.png'),
                radius: 50,
                backgroundColor: Colors.transparent,
              ),
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              Text(
                "Metamask : ${user.metamaskId}",
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 7),
                        backgroundColor:
                            const Color.fromRGBO(186, 215, 233, 1)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile())),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Themes.theme.primaryColor, fontSize: 20),
                    )),
              )
            ],
          ),
        ));
  }
}
