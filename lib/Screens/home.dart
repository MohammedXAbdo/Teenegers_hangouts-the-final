import 'dart:collection';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';
import 'package:googlemaps/Provider/UserProvider.dart';
import 'package:googlemaps/Screens/addflag.dart';
import 'package:googlemaps/Widgets/LocationStack.dart';
import 'package:googlemaps/Screens/favorite.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:googlemaps/Screens/profile.dart';
import 'package:googlemaps/Screens/addQuestions.dart';
import 'package:googlemaps/Widgets/home_user_pointes.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/custom_icons/custom_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  static String id = "home";
  @override
  _homeState createState() => _homeState();

}

class _homeState extends State<home> {
  BitmapDescriptor pinmarker;
  BitmapDescriptor marker;
  void _OnMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    setState(() {
      markers.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(37.43296265331126, -122.08832357078792),
        infoWindow: InfoWindow(
          title: "mohamed elshafey",
        ),
//     icon: markericon,
//       onTap: markertap(),
      ));
    });
  }

  int currentindex = 0;

  double lat, long;


  static LatLng _initialPosition;

// to get places detail (lat/lng)
  //GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: constants.kGoogleApiKey);

  static LatLng _lastMapPosition =
      LatLng(30.04578362730974, 31.201951056718826);

//  void setMarkerIcon() async {
//    markericon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(
//        size: Size(12,12)
//        ),
//        "images/marker.png");
//  }



// make sure to initialize before map loading

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1, 1)),
        'images/pinmarker.png')
        .then((d) {
      pinmarker = d;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1, 1)),
        'images/image2.png')
        .then((d) {
      marker = d;
    });
    getUser();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Provider.of<UserProvider>(context, listen: false).scores3 != 0&&Provider.of<UserProvider>(context, listen: false).scores3 != null) {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.04,
                        child: Icon(
                          Custom_icons.coins,
                          color: constants.primarycolor,
                          size: 40,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: new Text(
                      "Congratulations",
                      style: TextStyle(
                          fontFamily: 'font', fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      child: Text(
                          "You Get New +${Provider.of<UserProvider>(context, listen: false).scores3} Point"))
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        Provider.of<UserProvider>(context,listen: false).setScores(0);
      }
    });
    // TODO: implement initState
    super.initState();

    sharedpref();
  }
  getUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      user1 = user;
    });
  }
  FirebaseUser user1;

  double counter;
  bool clickable;
  sharedpref() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getDouble('counter') ?? 0;
    clickable = prefs.getBool('clickable') ?? true;
  }

  Set<Marker> markers = HashSet<Marker>();
  GoogleMapController googleMapController;

  String search;
  bool isLike;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String username = Provider.of<UserProvider>(context).UserName;
    var userprovider = Provider.of<UserProvider>(context);
    int collectedpointes = Provider.of<UserProvider>(context).Scores;

    Store store = Store();
    final _auth = FirebaseAuth.instance;
    bool isliked = false;
   // List<MarkerComments> markercomments = [];
    String urlLoad =
        'https://firebasestorage.googleapis.com/v0/b/double-zenith-280321.appspot.com/o/images%2Fheader%20bg.png?alt=media&token=2a399258-a53e-4ceb-99e8-0e151e9c05fa';
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          elevation: 1,
          centerTitle: true,
          backgroundColor: constants.whitecolor,
          title: Text(
            currentindex == 0
                ? "Home"
                : currentindex == 1 ? "Favourite" : "Profile",
            style: TextStyle(
                fontFamily: 'font',
                fontWeight: FontWeight.bold,
                color: constants.blackcolor),
          ),
        ),
        body: StreamBuilder(
            stream: store.MarkersStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var doc in snapshot.data.documents) {
                  var data = doc.data;

                  GeoPoint geoPoint = data[constants.Location];
                  double lat = geoPoint.latitude;
                  double long = geoPoint.longitude;
                  LatLng latLng = LatLng(lat, long);
                  markers.add(Marker(
                    icon: data[constants.pinMareker]==true?pinmarker:marker,
                    //make on tap on marker not window
                      infoWindow: InfoWindow(
                          title: data[constants.placeName],
                          snippet: 'Click to Show More Information',
                          onTap: () {
                            showModalBottomSheet(
                                elevation: 1,
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return StreamBuilder(
                                      stream: store.MarkersCommentStream(
                                          doc.documentID.toString()
                                      ),
                                      builder: (context, snapshot) {
                                       if (snapshot.hasData) {


                                         getCartTotal(
                                             doc.documentID.toString());



                                               if (snapshot.hasData) {
                                                 return Container(
                                                     height:
                                                     MediaQuery
                                                         .of(context)
                                                         .size
                                                         .height *
                                                         0.98,
                                                     color: Colors.white,
                                                     child: Scaffold(
                                                       appBar: AppBar(
                                                         elevation: 1,
                                                         centerTitle: true,
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
                                                         onPressed: () {
                                                           Navigator.of(
                                                               context).push(
                                                               MaterialPageRoute(
                                                                   builder: (
                                                                       context) =>
                                                                       addQuestions(
                                                                           doc
                                                                               .documentID
                                                                               .toString())));
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
                                                           children: <Widget>[
                                                             Container(
                                                               width:
                                                               MediaQuery
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
                                                               child: Row(
                                                                 children: [
                                                                   Builder(
                                                                   builder: (context)=>
                                                         (
                                                         AvatarGlow(
                                                         endRadius: 35,
                                                         child: LikeButton(
                                                           onTap: (bool isLiked) async {
                                                             final FirebaseUser user = await _auth.currentUser();
                                                             final uid = user.uid;
                                                             print(uid);
                                                             await store.updateFavouriteHeart(uid,doc
                                                                 .documentID
                                                                 .toString(),
                                                                 !isLiked,data[
                                                                 "${constants
                                                                     .placeName}"],data[
                                                                 constants
                                                                     .Location]) ;

                                                             /// send your request here
                                                             // final bool success= await sendRequest();

                                                             /// if failed, you can do nothing
                                                             // return success? !isLiked:isLiked;
//
////                                                                              print(snapshot.data.documents[0][constants.IsFavourite]);
//    print (islike);
                                                             print(!isLiked);
                                                             Scaffold.of(context).showSnackBar(SnackBar(content: Text("Place Added To Favourite",style: TextStyle(fontFamily: 'font'),)));
                                                             return !isLiked;

                                                           },
                                                           isLiked: isliked,
                                                           circleColor: CircleColor(
                                                               start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                                           bubblesColor: BubblesColor(
                                                             dotPrimaryColor: Color(0xff33b5e5),
                                                             dotSecondaryColor: Color(0xff0099cc),
                                                           ),
                                                         ),
                                                       )),
                                                 ),
                                                                   Center(
                                                                     child: Padding(
                                                                       padding: const EdgeInsets
                                                                           .symmetric(
                                                                           horizontal:
                                                                           10,
                                                                           vertical:
                                                                           10),
                                                                       child:
                                                                       Container(
                                                                         width: width*0.7,
                                                                         child: AutoSizeText(
                                                                           data["${constants
                                                                               .placeName}"] ==
                                                                               null
                                                                               ? ""
                                                                               : data[
                                                                           "${constants
                                                                               .placeName}"],
                                                                           style: TextStyle(
                                                                               fontFamily:
                                                                               'font',
                                                                               color: constants
                                                                                   .whitecolor),
                                                                           textAlign:
                                                                           TextAlign
                                                                               .center,
                                                                           softWrap:
                                                                           true,
                                                                           wrapWords:
                                                                           true,
                                                                           maxLines: 1,
                                                                           minFontSize: 4,
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ),

                                                             Container(
                                                               height:
                                                               height * 0.24,
                                                               width: width,
                                                               child: GoogleMap(
                                                                 myLocationButtonEnabled: false,
                                                                 mapType: MapType
                                                                     .normal,
                                                                 markers:
                                                                 markers,
                                                                 onMapCreated:
                                                                 _OnMapCreated,
                                                                 initialCameraPosition:
                                                                 CameraPosition(
                                                                     bearing:
                                                                     180,
                                                                     target:
                                                                     latLng,
                                                                     zoom:
                                                                     17),
                                                               ),
                                                             ),
                                                             Expanded(
                                                               child: Padding(
                                                                 padding:
                                                                 const EdgeInsets
                                                                     .all(
                                                                     15.0),
                                                                 child:
                                                                 Container(
                                                                     height: height *
                                                                         0.2,
                                                                     width:
                                                                     width,
                                                                     child:
                                                                     Container(
                                                                       child:
                                                                       Column(
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
                                                     child: Text('loading...',
                                                         style: TextStyle(
                                                             fontFamily:
                                                             'font')));
                                           }
                                       else return Container();

                                      });
                                });
                          }),
                      markerId: MarkerId(data[constants.placeName]),
                      position: latLng));
                  print(data[constants.Location]);
                }
              }

              return Stack(
                children: <Widget>[
                  currentindex == 0
                      ? Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                home_user_pointes(
                                  width: width,
                                  height: height,
                                  username: username,
                                  colllectedpointes: collectedpointes,
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: GoogleMap(
                                  myLocationButtonEnabled: false,
                                      mapType: MapType.normal,
                                      markers: markers,
                                      onMapCreated: _OnMapCreated,
                                      initialCameraPosition: CameraPosition(
                                          target: _lastMapPosition, zoom: 15),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.07,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.11,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Prediction p =
                                          await PlacesAutocomplete.show(
                                              context: context,
                                              apiKey: constants.kGoogleApiKey,
                                              mode: Mode.fullscreen,
                                              // Mode.fullscreen
                                              language: "Ar",
                                              onError: (e) {
                                                print(
                                                    "error:${e.errorMessage}");
                                              },
                                              components: [
                                            new Component(
                                                Component.country, "Eg")
                                          ]);
                                      _getLatLng(p);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0.5)
                                          ]),
                                      height: height * 0.08,
                                      width: width * 0.8,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(Icons.search),
                                          SizedBox(
                                            width: 20,
                                          ),
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
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: height * 0.09,
                              left: width * 0.03,
                              child: Row(
                                children: <Widget>[
                                  IgnorePointer(
                                    ignoring: false,
//                                        ignoring: clickable == null
//                                            ? true
//                                            : clickable, //userprovider.addplace,

                                    child: Opacity(
                                      opacity:
//                                              counter == null ? 0 : counter==2?1:0,
                                      1,
                                      child: AvatarGlow(
                                        glowColor: Colors.black,
                                        endRadius: 49,
                                        child: FloatingActionButton(
                                          heroTag: 'btn1',
                                          backgroundColor:
                                          constants.primarycolor,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 4),
                                              child: Container(
                                                child: AutoSizeText(
                                                  "  Add    place",
                                                  softWrap: true,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, addflag.id);
                                          },
                                          elevation: 2,
                                          tooltip: "Add Place",
                                        ),
                                      ),
                                    ),
                                  ),

                                  IgnorePointer(
                                    ignoring: true,
                                    child: Opacity(
                                      opacity: counter == null ? 1 : counter==2?0:1,
                                      child: AvatarGlow(
                                        animate: userprovider.addplace == false
                                            ? true
                                            : false,
                                        endRadius: 90,
                                        glowColor: Colors.black,
                                        child: FloatingActionButton.extended(
                                          heroTag: 'btn2',
                                          label: Text("Rank pin Places"),
                                          backgroundColor: Colors.black26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : currentindex == 1 ? favorite() : profile(),
                  Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      left: 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(22),
                          topLeft: Radius.circular(22),
                        ),
                        child: BottomNavigationBar(
                          currentIndex: currentindex,
                          onTap: (index) {
                            setState(() {
                              currentindex = index;
                            });
                          },
                          backgroundColor: constants.whitecolor,
                          elevation: 5,
                          items: [
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Custom_icons.explore,
                                ),
                                title: Text(
                                  "Explore",
                                  style: TextStyle(fontFamily: 'font'),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(Custom_icons.heart),
                                title: Text(
                                  "Favorites",
                                  style: TextStyle(fontFamily: 'font'),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(Custom_icons.profile),
                                title: Text(
                                  "Account",
                                  style: TextStyle(fontFamily: 'font'),
                                )),
                          ],
                          unselectedItemColor: Colors.grey,
                          selectedItemColor: constants.primarycolor,
                          showUnselectedLabels: true,
                        ),
                      ))
                ],
              );
            }),
      ),
    );
  }

  void _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(
        apiKey: constants.kGoogleApiKey); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude, longitude), zoom: 10, bearing: 90)));
    print(address);
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
