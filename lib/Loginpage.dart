import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text('Welcome User, \n Login to your Account',
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
              ),
              Text('Heading'),
              Text('Heading'),
            ],
          ),
        ),
      ),
    );
  }  
}