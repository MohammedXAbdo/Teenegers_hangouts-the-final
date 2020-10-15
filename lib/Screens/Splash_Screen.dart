import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googlemaps/Screens/introSlider.dart';
import 'package:googlemaps/Widgets/customtext.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  static String id = 'splashid';
  @override
  Splash createState() => Splash();
}

class Splash extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    sharedpref();
  }
  double counter;
  sharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getDouble('Introcounter') ;
  }
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(

            builder: (BuildContext context) => counter==1?waitngWidget():introSlider())));

    var assetsImage = new AssetImage(
        'images/new_logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300); //<- Creates a widget that displays an image.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
            /* appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor:
              Colors.blue, //<- background color to combine with the picture :-)
        ),*/
            body: Container(
                decoration: new BoxDecoration(color: Colors.white),
                child: Stack(children: <Widget>[
                  SvgPicture.asset(
                    constants.backgoungimage,
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: height,
                      width: width,
                      child: Column(children: <Widget>[
                        SizedBox(height: height*0.1,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          child: Container(
                            width: width * 0.2,
                            child: SvgPicture.asset(constants.icon),
                          ),
                        ),
                        //text
                        Center(
                            child: customText(
                                fontWeight: FontWeight.bold,
                                textcolor: constants.blackcolor,
                                size: 20,
                                text: "Teenagers Hangouts")),
                        //text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Container(
                                child: customText(
                              text: "Your Way ",
                              fontWeight: FontWeight.normal,
                              textcolor: constants.blackcolor,
                              size: 13,
                            )),
                          ),
                        ),
                        //text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                              child: FittedBox(
                            child: customText(
                                fontWeight: FontWeight.bold,
                                textcolor: constants.blackcolor,
                                size: 20,
                                text: "Find new place \n        now!"),
                          )),
                        ),
                        SizedBox(
                          height: height*0.1,
                        ),
                        Center(
                          child: Container(
                            width: width*0.6,
                            height: height*0.2,
                            child: LinearPercentIndicator(
                              width: width*0.6,
                              lineHeight: height*0.05,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: Colors.grey,
                              progressColor: constants.primarycolor,
                              animationDuration: 2100,
                              percent: 1,
                              center: Text("loading...",style: TextStyle(fontFamily: 'font'),),
                              addAutomaticKeepAlive: true,
                              animation: true,
                            ),
                          ),
                        )

                      ]))
                ]))));
  }
}
