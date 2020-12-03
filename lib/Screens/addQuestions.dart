import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/Provider/UserProvider.dart';
import 'package:googlemaps/Screens/QuestionsImojeSlider.dart';
import 'package:googlemaps/Screens/get2Questions.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:googlemaps/Widgets/GenderAndAge.dart';
import 'package:googlemaps/Widgets/add_location_widget.dart';
import 'package:googlemaps/Widgets/getLocationRateImoje.dart';
import 'package:googlemaps/Widgets/getQuestions.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/models/Markers.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';

class addQuestions extends StatefulWidget {
  static String id = "addflag";
  @override
  _addQuestionsState createState() => _addQuestionsState();
  String docid;
  addQuestions(this.docid);


}

class _addQuestionsState extends State<addQuestions> {
  int value = 0;

  static int currentindex = 0;
  void initState() {
    currentindex = 0;

    getUser();
    sharedpref();
  }
  double counter;

  sharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getDouble('counter') ?? 0;
  }
  getUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      user1 = user;
    });
  }
  FirebaseUser user1;

  PageController controller = PageController(initialPage: currentindex);
  var scrolldirection = Axis.horizontal;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Store  store = Store();
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value:FirebaseAuth.instance.onAuthStateChanged, )
      ],
      child: Material(
          child: Scaffold(
            appBar: AppBar(
                elevation: 1,
                centerTitle: true,
                backgroundColor: constants.whitecolor,
                title: Text(
                  "Answer this",
                  style: TextStyle(
                      fontFamily: 'font',
                      fontWeight: FontWeight.bold,
                      color: constants.blackcolor),
                ),
                leading: InkWell(
                    onTap: (){
                      if(currentindex==0){
                        Navigator.pop(context);
                      }else{
                        setState(() {
                          currentindex--;
                          controller.animateToPage(currentindex,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.bounceInOut);
                        });

                      }
                    },
                    child: Icon(Icons.arrow_back,))
            ),
            body:

            ListView(
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
                              totalSteps:9,
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
                            "Fill this",
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
                              getQuestions(
                                width: width,
                                height: height,
                                question1:  "•What do you do in this place?",
                                answer1: "Socializing with friends",
                                answer2: "playing sports ",
                                answer3: "eating and drinking",
                                answer4: "others ",
                                question2:'•When do you go to those places? ' ,
                                answer5:"Early  morning" ,
                                answer6: "day of week",
                                answer7: "seasonal" ,
                                answer8:"others" ,
                                question3: '••With Whom do you go with and meet there? ',
                                answer9: "Friends",
                                answer10: "family",
                                answer11: "Alone ",
                                answer12: "others",
                              ),


                              QuestionsImojeSlider(height: height,width: width,Question1:"I can freely move around in this place?" ,
                                Question2:'There is no direct control on me from adult in this place?',
                                Question3: 'I feel safe in this place ? ',pagenumber: 1,),
                              QuestionsImojeSlider(height: height,width: width,Question1:'I can express myself freely in this place? ' ,
                                Question2:'I feel excited in this places? ',
                                Question3: 'I feel motivated in this place?',pagenumber: 2,),
                              QuestionsImojeSlider(height: height,width: width,Question1:'I Feel accepted and welcomed ?' ,
                                Question2:'There is a lot of recreational opportunities here?',
                                Question3: 'I can see and interact  with other teens easily? ',pagenumber: 3,),
                              getLocationRateImoje(width: width, height: height,question13: 'I can do different activities in this place?',),
                              get2Questions(width: width, height: height,question1: "What are the behaviours you dislike (or disapprove of) that happen in this place?",
                                answer1: "Fights",answer2: "drugs",answer3: "smoking",answer4: "drinking alcohol",question2: "Have you or any of your friends been a victim of any of the following in or near this place?",
                                answer5: "teens physical fights",answer6: "Been robbed",
                                answer7: "assaulted or wounded",answer8: "Been sexually harassed",
                              ),
                              QuestionsImojeSlider(height: height,width: width,Question1:'Teens in this place interest in new experiences and thrill-seeking?' ,
                                Question2:'Teens sometimes cause troubles/negative behaviours in this place?',
                                Question3: 'No places are available for the Teens and their activities in public spaces? ',pagenumber: 4,),
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
                      builder: (context)=>
                          FlatButton(
                            onPressed: () {
                              String imojeRate = Provider.of<Addflagprovider>(context,listen: false).imojeCurrentIndex;
                              String question1 = Provider.of<Addflagprovider>(context,listen: false).question1;
                              String question2 = Provider.of<Addflagprovider>(context,listen: false).question2;
                              String question3 = Provider.of<Addflagprovider>(context,listen: false).question3;
                              String question4 = Provider.of<Addflagprovider>(context,listen: false).question4;
                              String question5 = Provider.of<Addflagprovider>(context,listen: false).question5;
                              String question6 = Provider.of<Addflagprovider>(context,listen: false).question6;
                              String question7 = Provider.of<Addflagprovider>(context,listen: false).question7;
                              String question8 = Provider.of<Addflagprovider>(context,listen: false).question8;
                              String question9 = Provider.of<Addflagprovider>(context,listen: false).question9;
                              String question10= Provider.of<Addflagprovider>(context,listen: false).question10;
                              String question11 = Provider.of<Addflagprovider>(context,listen: false).question11;
                              String question12 = Provider.of<Addflagprovider>(context,listen: false).question12;
                              String question13 = Provider.of<Addflagprovider>(context,listen: false).question13;
                              String question18 = Provider.of<Addflagprovider>(context,listen: false).question18;
                              String question19 = Provider.of<Addflagprovider>(context,listen: false).question19;
                              int value4 = Provider.of<Addflagprovider>(context,listen: false).value4;
                              int value5 = Provider.of<Addflagprovider>(context,listen: false).value5;
                              int value6 = Provider.of<Addflagprovider>(context,listen: false).value6;
                              int value7 = Provider.of<Addflagprovider>(context,listen: false).value7;
                              int value8 = Provider.of<Addflagprovider>(context,listen: false).value8;
                              int value9 = Provider.of<Addflagprovider>(context,listen: false).value9;
                              int value10 = Provider.of<Addflagprovider>(context,listen: false).value10;
                              int value11 = Provider.of<Addflagprovider>(context,listen: false).value11;
                              int value12 = Provider.of<Addflagprovider>(context,listen: false).value12;
                              int value13 = Provider.of<Addflagprovider>(context,listen: false).value13;
                              String Question151617Justifyprovider = Provider.of<Addflagprovider>(context,listen: false).question151617Justify;

                              String question15 = Provider.of<Addflagprovider>(
                                  context,
                                  listen: false)
                                  .question15;
                              String question16 = Provider.of<Addflagprovider>(
                                  context,
                                  listen: false)
                                  .question16;
                              String question17 = Provider.of<Addflagprovider>(
                                  context,
                                  listen: false)
                                  .question17;
                              String Question1Justifyprovider = Provider.of<Addflagprovider>(context,listen: false).question1Justify;
                              final addflagprovider =
                              Provider.of<Addflagprovider>(context,
                                  listen: false);
                              String Question1Justify ;
                              String Question151617Justify ;
                              var user = Provider.of<FirebaseUser>(context,listen: false);
                              String Age = Provider.of<Addflagprovider>(context,listen: false).age;
                              String Gender = Provider.of<Addflagprovider>(context,listen: false).gender;
                              if(currentindex==7){
                                var time  = DateTime.now();
                                if (ConnectionState.active != null){
                                  store.addMarkerComment(widget.docid, MarkerComments(user.uid, question1, question2, time,question3,question4,question5
                                      ,question6,question7,question8,question9,question10,question11,question12,question13,question15,question16,question17,
                                      question18,question19,imojeRate,value4
                                      ,value5,value6,value7,value8,value9,value10,value11,value12,value13,Age,Gender),Question1Justifyprovider,Question151617Justifyprovider);
                                  Provider.of<UserProvider>(context,listen: false).setScores((value*10),);
                                  store.updateScore(user1.uid, (value*10));
                                  controller.dispose();
                                  setState(() {
                                    currentindex=-1;
                                  });
                                  ShowAddPlaceButton();
                                  Navigator.pushNamed(context, waitngWidget.id);
                                }
                              }
                              if(currentindex==0&&question1!=null&&question2!=null&&question3!=null||currentindex==5
                                  ||currentindex==1&&question4!=null&&question5!=null&&question6!=null&&value4!=0&&value5!=0&&value6!=0||currentindex==2&&question7!=null&&question8!=null&&question9!=null&&value7!=0&&value8!=0&&value9!=0
                                  ||currentindex==3&&question10!=null&&question11!=null&&question12!=null&&value10!=0&&value11!=0&&value12!=0||currentindex==6||currentindex==4&&question13!=null&&imojeRate!=null&&value13!=0)  {
                                if (currentindex == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: TextField(
                                          onChanged: (str) {
                                            setState(() {
                                              Question1Justify = str;
                                            });
                                          },
                                        ),
                                        title: AutoSizeText(
                                          'Add Any Other Comments..',
                                          maxLines: 1,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                print(Question1Justify);
                                                if (Question1Justify != null) {
                                                  addflagprovider.Question1Justify(
                                                      Question1Justify);
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
                                if (currentindex == 5) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: TextField(
                                          onChanged: (str) {
                                            setState(() {
                                              Question151617Justify = str;
                                            });
                                          },
                                        ),
                                        title: AutoSizeText(
                                          'Specify For Questions!',
                                          maxLines: 1,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                // print(Question1Justify);
                                                if (Question151617Justify != null) {
                                                  addflagprovider.Question151617Justify(
                                                      Question151617Justify);
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
                                  if (value < 8) {
                                    value++;
                                  }

                                });
                                controller.animateToPage(currentindex,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.bounceInOut);
                              }else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Apply Empty fields",style: TextStyle(fontFamily: 'font'),)));
                              }

                            },
                            child: Center(
                              child: Text(
                                currentindex == 7 ? "Finish" : "Next",
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
          )),
    );
  }
  ShowAddPlaceButton()async{
    final prefs = await SharedPreferences.getInstance();

// set value

    if (counter!=2){
      prefs.setDouble('counter', counter+1);
      print("couuuuuuuuuuuuuuuuuunter${counter}");
      prefs.setBool('clickable', false);
    }

  }



}

