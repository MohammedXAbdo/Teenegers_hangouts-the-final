import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/Provider/UserProvider.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:googlemaps/Widgets/GenderAndAge.dart';
import 'package:googlemaps/Widgets/add_location_widget.dart';
import 'package:googlemaps/Widgets/getLocationRateImoje.dart';
import 'package:googlemaps/Widgets/getQuestions.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/models/Markers.dart';
import 'package:googlemaps/models/user.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';

import 'QuestionsImojeSlider.dart';

class addflag extends StatefulWidget {
  static String id = "addflag";
  @override
  _addflagState createState() => _addflagState();
}

class _addflagState extends State<addflag> {
  int value = 0;

  static int currentindex = 0;

  PageController controller = PageController(initialPage: currentindex);
  var scrolldirection = Axis.horizontal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedpref();
  }
  double counter;

  sharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getDouble('counter') ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Store store = Store();
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        )
      ],
      child:

            Material(
                child: Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      if (currentindex == 0) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          currentindex--;
                          controller.animateToPage(currentindex,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.bounceInOut);
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                    )),
                elevation: 1,
                centerTitle: true,
                backgroundColor: constants.whitecolor,
                title: Text(
                  "Add Place",
                  style: TextStyle(
                      fontFamily: 'font',
                      fontWeight: FontWeight.bold,
                      color: constants.blackcolor),
                ),
              ),
              body: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: Center(
                      child: Container(
                        height: height * 0.02,
                        width: width * 0.8,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: height * 0.025,
                              width: width * 0.8,
                              child: StepProgressIndicator(
                                totalSteps: 6,
                                currentStep: value,
                                size: 25,
                                padding: 0,
                                selectedColor: constants.primarycolor,
                                unselectedColor: constants.purblecolor,
                                roundedEdges: Radius.circular(10),
                              ),
                            ),
                            Positioned(
                              right: width * 0.05,
                              child: Text(
                                "+${value * 10} Point",
                                style: TextStyle(color: constants.orange),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Choose your Favorite Place...",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'font'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: width * 0.9,
                            height: height * 0.65,
                            child: PageView(
                              pageSnapping: true,
                              scrollDirection: scrolldirection,
                              physics: new NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  currentindex = index;
                                });
                              },
                              controller: controller,
                              children: <Widget>[
                                add_location_widget(
                                  height: height,
                                  width: width,
                                ),
                                getQuestions(
                                  width: width,
                                  height: height,
                                  question1: "•What do you do in this place?",
                                  answer1: "Socializing with friends",
                                  answer2: "playing sports ",
                                  answer3: "eating and drinking",
                                  answer4: "others ",
                                  question2:
                                      '•When do you go to those places? ',
                                  answer5: "Early  morning",
                                  answer6: "day of week",
                                  answer7: "seasonal",
                                  answer8: "others",
                                  question3:
                                      '••	With Whom do you go with and meet their? ',
                                  answer9: "Friends",
                                  answer10: "family",
                                  answer11: "Alone ",
                                  answer12: "others",
                                ),
                                QuestionsImojeSlider(
                                  height: height,
                                  width: width,
                                  Question1:
                                      "I can freely move around in this place?",
                                  Question2:
                                      'There is no direct control on me from adult in this place?',
                                  Question3: 'I feel safe in this place ? ',
                                  pagenumber: 1,
                                ),
                                QuestionsImojeSlider(
                                  height: height,
                                  width: width,
                                  Question1:
                                      'I can express myself freely in this place? ',
                                  Question2: 'I feel excited in this places? ',
                                  Question3: 'I feel motivated in this place?',
                                  pagenumber: 2,
                                ),
                                QuestionsImojeSlider(
                                  height: height,
                                  width: width,
                                  Question1: 'I Feel accepted?',
                                  Question2:
                                      'There is a lot of recreational opportunities here?',
                                  Question3:
                                      'I can see and interact  with other teens easily? ',
                                  pagenumber: 3,
                                ),
                                getLocationRateImoje(
                                  width: width,
                                  height: height,
                                  question13:
                                      'I can do different activities in this place?',
                                ),
                                GenderAndAge(width: width,height: height,question1: "What is Your Age?",answer1: "13-14",
                                answer2: "15-16",answer3: "16-17",answer4:"18-19" ,question2: "What is Your Gender?",
                                answer5: "Male",answer6: "Female",
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.06,
                      child: Builder(
                        builder: (context) => FlatButton(
                          onPressed: () {
                            final addflagprovider =
                                Provider.of<Addflagprovider>(context,
                                    listen: false);
                            String adrees = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .adress1;
                            String imojeRate = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .imojeCurrentIndex;
                            String question1 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question1;
                            String question2 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question2;
                            String question3 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question3;
                            String question4 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question4;
                            String question5 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question5;
                            String question6 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question6;
                            String question7 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question7;
                            String question8 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question8;
                            String question9 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question9;
                            String question10 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question10;
                            String question11 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question11;
                            String question12 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question12;
                            String question13 = Provider.of<Addflagprovider>(
                                    context,
                                    listen: false)
                                .question13;
                            int value4 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value4;
                            int value5 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value5;
                            int value6 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value6;
                            int value7 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value7;
                            int value8 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value8;
                            int value9 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value9;
                            int value10 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value10;
                            int value11 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value11;
                            int value12 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value12;
                            int value13 = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .value13;
                            double lat = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .lat;
                            double long = Provider.of<Addflagprovider>(context,
                                    listen: false)
                                .lang;
                            var user = Provider.of<FirebaseUser>(context,
                                listen: false);
                            String Age = Provider.of<Addflagprovider>(context,listen: false).age;
                            String Gender = Provider.of<Addflagprovider>(context,listen: false).gender;
                            String placeaddress;
                            if (currentindex == 6) {
                              var time = DateTime.now();
                              if (ConnectionState.active != null) {
                                store.addNarker(
                                    Markers(adrees, GeoPoint(lat, long)),
                                    MarkerComments(
                                        user.uid,
                                        question1,
                                        question2,
                                        time,
                                        question3,
                                        question4,
                                        question5,
                                        question6,
                                        question7,
                                        question8,
                                        question9,
                                        question10,
                                        question11,
                                        question12,
                                        question13,
                                        imojeRate,
                                        value4,
                                        value5,
                                        value6,
                                        value7,
                                        value8,
                                        value9,
                                        value10,
                                        value11,
                                        value12,
                                        value13,Age
                                    ,Gender));
                                store.updateScore(
                                    user.uid,
                                        (value * 10));
                                controller.dispose();
                                setState(() {
                                  currentindex = -1;
                                });
                                ShowAddPlaceButton();
                                Provider.of<UserProvider>(context,listen: false).setScores((value*10));
                                Navigator.pushNamed(context, waitngWidget.id);
                              }
                            }
                            if (currentindex == 0 &&
                                    adrees != null &&
                                    lat != null &&
                                    long != null ||
                                currentindex == 1 &&
                                    question1 != null &&
                                    question2 != null &&
                                    question3 != null ||
                                currentindex == 2 &&
                                    question4 != null &&
                                    question5 != null &&
                                    question6 != null&&
                                    value4 != 0 &&
                                    value5 != 0 &&
                                    value6 != 0 ||
                                currentindex == 3 &&
                                    question7 != null &&
                                    question8 != null &&
                                    question9 != null &&
                                    value7 != 0 &&
                                    value8 != 0 &&
                                    value9 != 0||
                                currentindex == 4 &&
                                    question10 != null &&
                                    question11 != null &&
                                    question12 != null &&
                                    value10 != 0 &&
                                    value11 != 0 &&
                                    value12 != 0||
                                currentindex == 5 &&
                                    question13 != null &&
                            value13 != 0 &&
                                    imojeRate != null) {
                              if (currentindex == 0 &&
                                  lat != null &&
                                  long != null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: TextField(
                                            onChanged: (str) {
                                              setState(() {
                                                placeaddress = str;
                                              });
                                            },
                                          ),
                                          title: Text(
                                              'Enter Place Name\n Or Skip'),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  print(placeaddress);
                                                  if (placeaddress != null) {
                                                    addflagprovider.getaddress(
                                                        placeaddress);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Text('Ok')),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Skip'))
                                          ],
                                        ));
                              }
                              setState(() {
                                currentindex++;
                                if (value < 6) {
                                  value++;
                                }
                              });

                              controller.animateToPage(currentindex,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.bounceInOut);
                            } else {
                              if (lat == null && long == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                  "Please Add Marker on Map",
                                  style: TextStyle(fontFamily: 'font'),
                                )));
                              } else
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                  "Please Apply Empty fields",
                                  style: TextStyle(fontFamily: 'font'),
                                )));
                            }
                          },
                          child: Center(
                            child: Text(
                              currentindex == 6 ? "Finish" : "Next",
                              style: TextStyle(fontFamily: 'font'),
                            ),
                          ),
                          color: constants.primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
    );
  }
  ShowAddPlaceButton()async{
    final prefs = await SharedPreferences.getInstance();

// set value
    if (counter!=5){
      prefs.setDouble('counter', counter+1);
      prefs.setBool('clickable', false);
    }

  }
}
