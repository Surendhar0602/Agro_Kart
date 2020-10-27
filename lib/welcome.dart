import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'RoundedButton.dart';
import 'login.dart';
import 'lodingpage.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'logo',
                child: Image.network(
                  "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fcdn.onlinewebfonts.com%2Fsvg%2Fimg_366353.png&f=1&nofb=1",
                  height: 60.0,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            RoundedButtons(
              colour: Colors.lightBlueAccent,
              title: "Login",
              onpressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            RoundedButtons(
                colour: Colors.white,
                title: "Register",
                textcolour: Colors.lightBlueAccent,
                onpressed: () {
                  Navigator.pushNamed(context, '/register');
                })
          ],
        ),
      ),
    );
  }
}

