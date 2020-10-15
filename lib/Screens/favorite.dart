import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';
import 'package:googlemaps/Screens/addQuestions.dart';
import 'package:googlemaps/Widgets/LocationStack.dart';
import 'package:googlemaps/custom_icons/custom_icons.dart';
import 'package:googlemaps/models/Markers.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:googlemaps/constants.dart';

class favorite extends StatefulWidget {
  @override
  _favoriteState createState() => _favoriteState();
}


class _favoriteState extends State<favorite> {
  void initState() {
    // TODO: implement initState
    super.initState();
  getUser();
  }

  getUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      user1 = user;
    });
  }
  FirebaseUser user1;


  String urlLoad =
      'https://firebasestorage.googleapis.com/v0/b/double-zenith-280321.appspot.com/o/images%2Fheader%20bg.png?alt=media&token=2a399258-a53e-4ceb-99e8-0e151e9c05fa';
  @override
  Widget build(BuildContext context) {


    Store store = Store();
    var user = Provider.of<FirebaseUser>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var data;


    return Material(
      child: Scaffold(
          backgroundColor: constants.purblecolor,
          body: StreamBuilder(
            stream: store.MarkersStream(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                var doc = snapshot.data.documents;

                  return StreamBuilder(
                        stream: store.favourite(user.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data2 = snapshot.data.documents;
                            if (snapshot.data.documents.length == 0) {
                              return Center(
                                child: Text(
                                  "No Favourite yet ...",
                                  style: TextStyle(fontFamily: 'font'),
                                ),
                              );
                            }
                            return ListView.builder(

                                itemCount: snapshot.data.documents.length,
                                padding: EdgeInsets.all(8),
                                itemBuilder: (context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: height * 0.17,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            color: Colors.white),
                                        child: Column(
                                          children: <Widget>[
                                            LayoutBuilder(
                                              builder: (context, constrain) =>
                                                  Container(
                                                    height: height * 0.11,
                                                    decoration: BoxDecoration(
                                                      //  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
                                                        border: Border(
                                                            bottom:
                                                            BorderSide(
                                                                color: Colors
                                                                    .grey))
                                                      // border: Border(bottom:BorderSide(color: Colors.grey)),
                                                      //color: Colors.amber,
                                                    ),
                                                    child: Container(
                                                        width: constrain
                                                            .maxWidth,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .all(15.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                  "images/icon.svg"),
                                                            ),
                                                            Container(
                                                              width: width *
                                                                  0.5,
                                                              child: AutoSizeText(

                                                                "${snapshot.data
                                                                    .documents[index][constants
                                                                    .placeName]}",
                                                                style: TextStyle(
                                                                  fontFamily: 'font',

                                                                ),
                                                                maxLines: 1,
                                                                minFontSize: 12,
                                                                softWrap: true,
                                                                maxFontSize: 15,
                                                                wrapWords: true,
                                                                textScaleFactor: 1,
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: SvgPicture
                                                                      .asset(
                                                                      "images/stars.svg"),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                            ),
                                            SizedBox(
                                              height: height * 0.015,
                                            ),
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      elevation: 1,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (builder) {
                                                        return StreamBuilder(
                                                            stream: store
                                                                .MarkersCommentStream(
                                                                data2[index][constants
                                                                    .time]),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                //markercomments = [];
                                                                  data = snapshot.data.documents;


                                                                getCartTotal(
                                                                    data2[index][constants
                                                                        .time]);
                                                              }

                                                              return StreamBuilder(
                                                                  stream:
                                                                  store
                                                                      .favouriteLike(
                                                                     user1.uid),
                                                                  builder:
                                                                      (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      return Container(
                                                                          height: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.98,
                                                                          color:
                                                                          Colors
                                                                              .white,
                                                                          child: Scaffold(
                                                                            appBar: AppBar(
                                                                              elevation: 1,
                                                                              centerTitle:
                                                                              true,
                                                                              backgroundColor:
                                                                              constants
                                                                                  .whitecolor,
                                                                              title: Text(
                                                                                "Do You Love This Place?",
                                                                                style: TextStyle(
                                                                                    fontFamily:
                                                                                    'font',
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .bold,
                                                                                    color: constants
                                                                                        .blackcolor),
                                                                              ),
                                                                            ),
                                                                            floatingActionButton:
                                                                            FloatingActionButton
                                                                                .extended(
                                                                              onPressed:
                                                                                  () {
                                                                                Navigator
                                                                                    .of(
                                                                                    context)
                                                                                    .push(
                                                                                    MaterialPageRoute(
                                                                                        builder: (
                                                                                            context) =>
                                                                                            addQuestions(
                                                                                                data2[index][constants
                                                                                                    .time])));
                                                                              },
                                                                              label: Text(
                                                                                  "Add Your Answers now!"),
                                                                              backgroundColor:
                                                                              constants
                                                                                  .primarycolor,
                                                                            ),
                                                                            floatingActionButtonLocation:
                                                                            FloatingActionButtonLocation
                                                                                .centerFloat,
                                                                            body: Container(
                                                                              child: Column(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Container(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width,
                                                                                    height: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.07,
                                                                                    color: constants
                                                                                        .primarycolor,
                                                                                    child:
                                                                                    Center(
                                                                                      child:
                                                                                      Padding(
                                                                                        padding:
                                                                                        const EdgeInsets
                                                                                            .symmetric(
                                                                                            horizontal: 10,
                                                                                            vertical: 10),
                                                                                        child:
                                                                                        AutoSizeText(
                                                                                          data2[index]["${constants
                                                                                              .placeName}"] ==
                                                                                              null
                                                                                              ? ""
                                                                                              : data2[index]["${constants
                                                                                              .placeName}"],
                                                                                          style: TextStyle(
                                                                                              fontFamily: 'font',
                                                                                              color: constants
                                                                                                  .whitecolor),
                                                                                          textAlign: TextAlign
                                                                                              .center,
                                                                                          softWrap: true,
                                                                                          wrapWords: true,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  LocationStack(
                                                                                    height:
                                                                                    height,
                                                                                    width:
                                                                                    width,
                                                                                    placImage:
                                                                                    doc[index][constants.PlaceImage],
                                                                                    urlLoad:
                                                                                    urlLoad,
                                                                                    docId:
                                                                                    data2[index][constants
                                                                                        .time],
                                                                                    store:
                                                                                    store,
                                                                                    placeName: data2[index]["${constants
                                                                                        .placeName}"],
                                                                                    location: data2[index][constants
                                                                                        .Location],
                                                                                  ),

                                                                                  Expanded(
                                                                                    child:
                                                                                    Padding(
                                                                                      padding:
                                                                                      const EdgeInsets
                                                                                          .all(
                                                                                          15.0),
                                                                                      child: Container(
                                                                                          height: height *
                                                                                              0.2,
                                                                                          width: width,
                                                                                          child: Container(
                                                                                            child: Column(
                                                                                              children: <
                                                                                                  Widget>[
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Peer Relationships',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: ((Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage4with12percent) ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : (Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage4with12percent)),
                                                                                                      center: Text(
                                                                                                        "${(Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage4with12 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : ((Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage4with12)))}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Sense of freedom',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: ((Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage5with6percent) ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : (Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage5with6percent)),
                                                                                                      center: Text(
                                                                                                        "${(Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage5with6 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : (Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage5with6))}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Safety',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage7percent ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage7percent,
                                                                                                      center: Text(
                                                                                                        "${Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage7 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage7}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Self expression',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: ((Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage8with10percent) ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : (Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage8with10percent)),
                                                                                                      center: Text(
                                                                                                        "${(Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage8with10 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : (Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage8with10))}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Enjoyment',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage9percent ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage9percent,
                                                                                                      center: Text(
                                                                                                        "${Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage9 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage9}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                        'Acceptance',
                                                                                                        style: TextStyle(
                                                                                                            fontFamily: 'font')),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage11percent ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage11percent,
                                                                                                      center: Text(
                                                                                                        "${Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage11 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage11}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                                      .spaceBetween,
                                                                                                  children: <
                                                                                                      Widget>[
                                                                                                    Text(
                                                                                                      'variety',
                                                                                                      style: TextStyle(
                                                                                                          fontFamily: 'font'),
                                                                                                    ),
                                                                                                    new LinearPercentIndicator(
                                                                                                      width: 140.0,
                                                                                                      lineHeight: 14.0,
                                                                                                      percent: Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage13percent ==
                                                                                                          null
                                                                                                          ? 0
                                                                                                          : Provider
                                                                                                          .of<
                                                                                                          Addflagprovider>(
                                                                                                          context)
                                                                                                          .valuePrecentage13percent,
                                                                                                      center: Text(
                                                                                                        "${Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage13 ==
                                                                                                            null
                                                                                                            ? 0
                                                                                                            : Provider
                                                                                                            .of<
                                                                                                            Addflagprovider>(
                                                                                                            context)
                                                                                                            .valuePrecentage13}%",
                                                                                                        style: new TextStyle(
                                                                                                            fontSize: 12.0),
                                                                                                      ),
                                                                                                      trailing: Icon(
                                                                                                          Icons
                                                                                                              .mood),
                                                                                                      linearStrokeCap: LinearStrokeCap
                                                                                                          .roundAll,
                                                                                                      backgroundColor: Colors
                                                                                                          .grey,
                                                                                                      progressColor: constants
                                                                                                          .primarycolor,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ));
                                                                    } else
                                                                      return Center(
                                                                          child: Text(
                                                                              'loading...',
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                  'font')));
                                                                  });
                                                            });
                                                      });
                                                },
                                                child: Text(
                                                  "See More",
                                                  style: TextStyle(
                                                      fontFamily: 'font',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: constants.orange),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                });
                          } else if (snapshot.data == null) {
                            print(snapshot.data);
                            return Center(
                              child: Text(
                                "No Fav Yet...",
                                style: TextStyle(fontFamily: 'font'),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            print(snapshot.data);
                          } else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Center(child: Text('Error'));
                          }
                          return Center(
                            child: Text(
                              "Loading...",
                              style: TextStyle(fontFamily: 'font'),
                            ),
                          );
                        }
                    );
                }

              else
                return  Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(fontFamily: 'font'),
                  ),
                );
            }
          )
    ),
    );
  }
  getCartTotal(String docId) async {
    var addflag = Provider.of<Addflagprovider>(context, listen: false);
    var value4 = 0;
    var value5 = 0;
    var value6 = 0;
    var value7 = 0;
    var value8 = 0;
    var value9 = 0;
    var value10 = 0;
    var value11 = 0;
    var value12 = 0;
    var value13 = 0;
    QuerySnapshot snapshot = await Firestore.instance
        .collection(constants.Markerscollection)
        .document(docId)
        .collection(constants.MarkersCommentscollection)
        .getDocuments();

    if (snapshot == null) {
      print("fgvhjklfdfghjkdfcvbn");
      return;
    }

    snapshot.documents.forEach((doc) {
      value4 = value4 + doc.data[constants.Value4];
      value5 = value5 + doc.data[constants.Value5];
      value6 = value6 + doc.data[constants.Value6];
      value7 = value7 + doc.data[constants.Value7];
      value8 = value8 + doc.data[constants.Value8];
      value9 = value9 + doc.data[constants.Value9];
      value10 = value10 + doc.data[constants.Value10];
      value11 = value11 + doc.data[constants.Value11];
      value12 = value12 + doc.data[constants.Value12];
      value13 = value13 + doc.data[constants.Value13];
    });
    addflag.value4Percentwith12(
        (((value4 / snapshot.documents.length) * 100) / 4 +
            ((value12 / snapshot.documents.length) * 100) / 4) /
            2);
    addflag.value4Percentwith12percent(
        ((((value4 / snapshot.documents.length) * 100) / 4 +
            ((value12 / snapshot.documents.length) * 100) / 4) /
            2) /
            100);
    addflag.value5Percentwith6(
        (((value5 / snapshot.documents.length) * 100) / 4 +
            ((value6 / snapshot.documents.length) * 100) / 4) /
            2);
    addflag.value5Percentwith6percent(
        ((((value5 / snapshot.documents.length) * 100) / 4 +
            ((value6 / snapshot.documents.length) * 100) / 4) /
            2) /
            100);
    addflag.value7Percent(((value7 / snapshot.documents.length) * 100) / 4);
    addflag.value7Percentpercent(
        (((value7 / snapshot.documents.length) * 100) / 4) / 100);
    addflag.value8Percentwith10(
        (((value8 / snapshot.documents.length) * 100) / 4 +
            ((value10 / snapshot.documents.length) * 100) / 4) /
            2);
    addflag.value8Percentwith10percent(
        ((((value8 / snapshot.documents.length) * 100) / 4 +
            ((value10 / snapshot.documents.length) * 100) / 4) /
            2) /
            100);
    addflag.value9Percent(((value9 / snapshot.documents.length) * 100) / 4);
    addflag.value9Percentpercent(
        (((value9 / snapshot.documents.length) * 100) / 4) / 100);
    addflag.value11Percent(((value11 / snapshot.documents.length) * 100) / 4);
    addflag.value11Percentpercent(
        (((value11 / snapshot.documents.length) * 100) / 4) / 100);
    addflag.value13Percent(((value13 / snapshot.documents.length) * 100) / 4);
    addflag.value13Percentpercent(
        (((value13 / snapshot.documents.length) * 100) / 4) / 100);
  }
}
