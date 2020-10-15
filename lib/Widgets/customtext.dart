import 'package:flutter/material.dart';
class customText extends StatelessWidget {
  final FontWeight fontWeight;
  Color textcolor;
  double size;
  String text;
  customText({
    Key key, @required this.fontWeight,
    @required this.textcolor,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          fontFamily: "font",
          fontWeight: fontWeight,
          color: textcolor,
          fontSize: size

      ),
    );
  }
}