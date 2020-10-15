
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  String UserName;
  int Scores;
  int Age;
  String accesstoken;
  bool addplace = false;
  double buttonOpacity = 0;
  bool islike;
  int scores3;

  changeislike(bool like){
    islike = like;
  }

  changedaddPlace(){
    addplace = true;
    buttonOpacity = 1;
    
  }
  setScores(int scores1){
    this.scores3 = scores1;
    notifyListeners();
  }

  getaccesstoken(String acess){
    accesstoken = acess;
    notifyListeners();
  }
  getUserInformation(String name,int scores,int age){
    UserName = name;
    Scores = scores;
    Age = age;
    notifyListeners();
  }




}