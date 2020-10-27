import 'package:flutter/material.dart';

class RoundedButtons extends StatelessWidget {
  RoundedButtons(
      {@required this.title,
      this.colour,
      @required this.onpressed,
      this.textcolour});
  final String title;
  final Color colour;
  final Function onpressed;
  final Color textcolour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: onpressed,
          child: Text(
            title,
            style: TextStyle(color: textcolour, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
