
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class modelHud extends ChangeNotifier{
  bool isloading = false;
  FirebaseAuth user;
   isprogressloding(bool is_loading){
     isloading = is_loading;
     notifyListeners();
   }


}