import 'package:flutter/material.dart';
import 'package:googlemaps/constants.dart';
class Search_Wideget extends StatelessWidget {
  const Search_Wideget({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height*0.11,),
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
                ,color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey,spreadRadius: 0.5)
                ]
            ),
            height: height*0.08,
            width: width*0.8,
            child: Row(
              children: <Widget>[
                SizedBox(width: 20,),
                Icon(Icons.search),
                SizedBox(width: 20,),
                Text(
                  "Search",
                  style: TextStyle(
                      fontFamily: 'font',
                      fontWeight: FontWeight.bold,
                      color: constants.blackcolor),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

