import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroSliderItem extends StatelessWidget {
  String imageUrl;
  String firstTitle;
  String secondTitle;
  IntroSliderItem({@required this.firstTitle,@required this.imageUrl,@required this.secondTitle});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
         SvgPicture.asset("images/background.svg",fit: BoxFit.cover,),
          Column(
            children: <Widget>[
              SizedBox(
                height: height*0.1,
              ),
              Center(child: SvgPicture.asset(imageUrl,fit: BoxFit.cover,)),
              SizedBox(height: height*0.07,),
              Text(firstTitle,style: TextStyle(fontFamily: 'font',fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
              SizedBox(height: height*0.02,),
              Text(secondTitle,style: TextStyle(fontFamily: 'font',),textAlign: TextAlign.center,)
            ],
          )
        ],
      ),

    );
  }
}
