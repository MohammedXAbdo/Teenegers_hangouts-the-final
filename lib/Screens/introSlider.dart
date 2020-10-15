import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:googlemaps/Widgets/IntroSliderItem.dart';
import 'package:googlemaps/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class introSlider extends StatefulWidget {
  static String introid = "id";
  @override
  _introSliderState createState() => _introSliderState();

}

class _introSliderState extends State<introSlider> {

  static int currentindex = 0;
  static double currentindexdots = 0;
  void initState() {
    currentindex = 0;
    currentindexdots = 0;
  }

  PageController controller = PageController(initialPage: currentindex);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics:new NeverScrollableScrollPhysics(),
              pageSnapping: false,
              allowImplicitScrolling: false,
              reverse: false,
              controller: controller,
              children: <Widget>[
               IntroSliderItem(firstTitle:"Discover",secondTitle: "Discover places and explore like a teen ",imageUrl: "images/intro1.svg",),
                IntroSliderItem(firstTitle:"Find",secondTitle: "Find top- favourite places and hangout spots, wherever you are ",imageUrl: "images/intro2.svg",),
                IntroSliderItem(firstTitle:"Decide",secondTitle: "Decide on the best places to go with reviews, ratings, and pictures ",imageUrl: "images/intro3.svg",),
                IntroSliderItem(firstTitle:"Help",secondTitle: "Help other teens to discover the best places by sharing reviews, photos and more",imageUrl: "images/intro4.svg",),
              ],
            ),
            Positioned(
              bottom: height*0.2,
              left: width*0.2,
              right: width*0.2,
              child: new DotsIndicator(
                dotsCount: 4,
                position:currentindexdots,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  activeColor: constants.primarycolor
                ),
              ),
            ),
            Positioned(
              bottom: height*0.1,
              left: width*0.2,
              right: width*0.2,
              child: Center(
                child: Container(
                  width: width * 0.7,
                  height: height * 0.06,
                  child: FlatButton(child: Text(currentindex==3?"Finish":"Next",style: TextStyle(fontFamily: 'font'),),color: constants.primarycolor

                  ,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),onPressed: (){
                    if (currentindex<3&&currentindexdots<3){
                      setState(() {
                        currentindex++;
                        currentindexdots++;
                      });
                      controller.animateToPage(currentindex, duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
                    }else{
                      ShowIntroCounter();
                      Navigator.pushNamed(context, waitngWidget.id);
                    }
                    }
                    ),
                ),
              )),

          ],
        ),
      ),
    );
  }
  ShowIntroCounter()async{
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setDouble('Introcounter', 1);
  }
}
