

import 'package:flutter/cupertino.dart';

class Addflagprovider extends ChangeNotifier{
  String imojeCurrentIndex;
  String adress1 ;
  String question1;
  String question18;
  String question19;
  String question1Justify;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String question8;
  String question9;
  String question10;
  String question11;
  String question12;
  String question13;
  String question15;
  String question16;
  String question17;
  String question151617Justify;
  String age;
  String gender;
  int value4;
  int value5;
  int value6;
  int value7;
  int value8;
  int value9;
  int value10;
  int value11;
  int value12;
  int value13;
  double valuePrecentage4with12;
  double valuePrecentage5with6;
  double valuePrecentage6;
  double valuePrecentage7;
  double valuePrecentage8with10;
  double valuePrecentage9;
  double valuePrecentage10;
  double valuePrecentage11;
  double valuePrecentage12;
  double valuePrecentage13;
  double valuePrecentage4with12percent;
  double valuePrecentage5with6percent;
  double valuePrecentage6percent;
  double valuePrecentage7percent;
  double valuePrecentage8with10percent;
  double valuePrecentage9percent;

  double valuePrecentage11percent;

  double valuePrecentage13percent;
  String question14;
  double lat;
  double lang;



  getlatlang(double latt,double long){
    lat = latt ;
    lang = long;
    notifyListeners();
  }

  value4Result(int val){
    value4 = val;
    notifyListeners();
  }
  value4Percentwith12(double val){
    valuePrecentage4with12 = val.roundToDouble();
    notifyListeners();
  }
  value5Percentwith6(double val){
    valuePrecentage5with6 = val.roundToDouble();
    notifyListeners();
  }
  value6Percent(double val){
    valuePrecentage6 = val.roundToDouble();
    notifyListeners();
  }
  value7Percent(double val){
    valuePrecentage7 = val.roundToDouble();
    notifyListeners();
  }
  value8Percentwith10(double val){
    valuePrecentage8with10 = val.roundToDouble();
    notifyListeners();
  }
  value9Percent(double val){
    valuePrecentage9 = val.roundToDouble();
    notifyListeners();
  }
  value10Percent(double val){
    valuePrecentage10 = val.roundToDouble();
    notifyListeners();
  }
  value11Percent(double val){
    valuePrecentage11 = val.roundToDouble();
    notifyListeners();
  }
  value12Percent(double val){
    valuePrecentage12 = val.roundToDouble();
    notifyListeners();
  }
  value13Percent(double val){
    valuePrecentage13 = val.roundToDouble();
    notifyListeners();
  }
  value4Percentwith12percent(double val){
    valuePrecentage4with12percent = val;
    notifyListeners();
  }
  value5Percentwith6percent(double val){
    valuePrecentage5with6percent = val;
    notifyListeners();
  }

  value7Percentpercent(double val){
    valuePrecentage7percent = val;
    notifyListeners();
  }
  value8Percentwith10percent(double val){
    valuePrecentage8with10percent = val;
    notifyListeners();
  }
  value9Percentpercent(double val){
    valuePrecentage9percent = val;
    notifyListeners();
  }
  value11Percentpercent(double val){
    valuePrecentage11percent = val;
    notifyListeners();
  }


  value13Percentpercent(double val){
    valuePrecentage13percent = val;
    notifyListeners();
  }
  value5Result(int val){
    value5 = val;
    notifyListeners();
  }
  value6Result(int val){
    value6 = val;
    notifyListeners();
  }
  value7Result(int val){
    value7 = val;
    notifyListeners();
  }
  value8Result(int val){
    value8 = val;
    notifyListeners();
  }
  value9Result(int val){
    value9 = val;
    notifyListeners();
  }
  value10Result(int val){
    value10 = val;
    notifyListeners();
  }
  value11Result(int val){
    value11 = val;
    notifyListeners();
  }
  value12Result(int val){
    value12 = val;
    notifyListeners();
  }
  value13Result(int val){
    value13 = val;
    notifyListeners();
  }


  question1Result(String quest){
    question1 = quest;
    notifyListeners();
  }
  question3Result(String quest){
    question3 = quest;
    notifyListeners();
  }
  question10Result(String quest){
    question10 = quest;
    notifyListeners();
  }
  question11Result(String quest){
    question11 = quest;
    notifyListeners();
  }
  question12Result(String quest){
    question12 = quest;
    notifyListeners();
  }
  question13Result(String quest){
    question13 = quest;
    notifyListeners();
  }
  question19Result(String quest){
    question19 = quest;
    notifyListeners();
  }
  question18Result(String quest){
    question18 = quest;
    notifyListeners();
  }
  question15Result(String quest){
    question15 = quest;
    notifyListeners();
  }
  question16Result(String quest){
    question16 = quest;
    notifyListeners();
  }
  question17Result(String quest){
    question17 = quest;
    notifyListeners();
  }
  question14Result(String quest){
    question14 = quest;
    notifyListeners();
  }
  question4Result(String quest){
    question4 = quest;
    notifyListeners();
  }
  question5Result(String quest){
    question5 = quest;
    notifyListeners();
  }
  question6Result(String quest){
    question6 = quest;
    notifyListeners();
  }
  question7Result(String quest){
    question7 = quest;
    notifyListeners();
  }
  question8Result(String quest){
    question8 = quest;
    notifyListeners();
  }
  question9Result(String quest){
    question9 = quest;
    notifyListeners();
  }
  question2Result(String questio){
    question2 = questio;
    notifyListeners();
  }
  question1Age(String questio){
    age = questio;
    notifyListeners();
  }
  question2Gender(String questio){
    gender = questio;
    notifyListeners();
  }
  imojeRate(String imojeindex){
    imojeCurrentIndex = imojeindex;

    notifyListeners();
  }
  getaddress(String adress){
    adress1=adress;
    notifyListeners();
  }

  Question1Justify(String adress){
    question1Justify=adress;
    notifyListeners();
  }
  Question151617Justify(String adress){
    question151617Justify=adress;
    notifyListeners();
  }
}