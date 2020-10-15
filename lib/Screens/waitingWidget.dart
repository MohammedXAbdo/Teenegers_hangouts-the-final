import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/Screens/home.dart';
import 'package:googlemaps/Screens/loginScreen.dart';
import 'package:provider/provider.dart';
class waitngWidget extends StatefulWidget {
  static String id  = 'waitingwidget';

  @override
  _waitngWidgetState createState() => _waitngWidgetState();
}

class _waitngWidgetState extends State<waitngWidget> {
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
       providers: [
         StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
       ],
       child: Builder(
         builder: (context)=>
          Material(
         child: Provider.of<FirebaseUser>(context)==null? loginScreen():home(),
     ),
       ),
     );
  }
}
