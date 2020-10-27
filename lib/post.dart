import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class post extends StatefulWidget {
  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
  final firestore = FirebaseFirestore.instance;
  String msg;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  FirebaseUser loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
       // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50.0),
        Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            maxLines: 10,
            maxLength: 500,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.redAccent)),
                hintText: 'Express your feelings'),
            onChanged: (value) {
              msg = value;
            },
          ),
        ),
        FlatButton(
            onPressed: () {
              firestore
                  .collection('posts')
                  .add({'userPost': msg, });
            },
            child: Text("Post"))
      ],
    );
  }
}
