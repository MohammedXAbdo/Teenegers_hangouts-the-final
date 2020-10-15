import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:googlemaps/Provider/UserProvider.dart';
import 'package:googlemaps/Provider/modelHud.dart';
import 'package:googlemaps/Screens/Splash_Screen.dart';
import 'package:googlemaps/Screens/addflag.dart';
import 'package:googlemaps/Screens/home.dart';
import 'package:googlemaps/Screens/introSlider.dart';
import 'package:googlemaps/Screens/loginScreen.dart';
import 'package:googlemaps/Screens/signup.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:provider/provider.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider<modelHud>(
      create: (context) => modelHud(),
    ),
    ChangeNotifierProvider<Addflagprovider>(
      create: (context) => Addflagprovider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
    ),

  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Phoenix(child: Splash_Screen()),
    routes: {
      introSlider.introid:(context)=>introSlider(),
      Splash_Screen.id:(context)=>Splash_Screen(),
      addflag.id: (context) => addflag(),
      waitngWidget.id: (context) => waitngWidget(),
      loginScreen.id: (context) => loginScreen(),
      signup.id: (context) => signup(),
      home.id: (context) => home()
    },
  ),
));