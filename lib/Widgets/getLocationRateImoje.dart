import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';
import 'package:googlemaps/constants.dart';


class getLocationRateImoje extends StatefulWidget {
  final double width;
  final double height;
  final String question13;

  getLocationRateImoje({
    Key key,
    @required this.width,
    @required this.height, this.question13,
  }) : super(key: key);

  @override
  _getLocationRateImojeState createState() => _getLocationRateImojeState();
}

class _getLocationRateImojeState extends State<getLocationRateImoje> {
  int imojecurrentindex1 = 0;
  @override
  Widget build(BuildContext context) {
    final addflagprovider = Provider.of<Addflagprovider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: constants.whitecolor,
      ),
      width: widget.width * 0.9,
      height: widget.height * 0.65,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: constants.whitecolor,
            ),
            height: widget.height * 0.1,
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Flexible(
                      child: Center(
                    child: Text(
                      "Answer This",
                      style: TextStyle(fontFamily: 'font'),
                    ),
                  ))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Center(
                child:Container(
                  padding: EdgeInsets.symmetric(vertical:2),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: AutoSizeText("${widget.question13}",style: TextStyle(
                            fontFamily: 'font'
                        ),softWrap: true,maxLines: 1,
                          maxFontSize: 12,

                          minFontSize: 8,),
                      ),
                      Container(

                        child: ReviewSlider(


                            options: ['Strongly disagree','Disagree','none','agree','Strongly agree'],
                            onChange: (index) {

                                index==0?addflagprovider.question13Result("Strongly disagree"):index==1?addflagprovider.question13Result("Disagree"):index==2?addflagprovider.question13Result("none")
                                    :index==3?addflagprovider.question13Result("agree"):index==4?addflagprovider.question13Result("Strongly agree"):"";
                                index==0?addflagprovider.value13Result(1):index==1?addflagprovider.value13Result(2):index==2?addflagprovider.value13Result(0)
                                    :index==3?addflagprovider.value13Result(3):index==4?addflagprovider.value13Result(4):0;


                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Center(
                child:Container(
                  padding: EdgeInsets.symmetric(vertical:2),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: AutoSizeText("I feel exited in this place ",style: TextStyle(
                            fontFamily: 'font'
                        ),softWrap: true,maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 8,),
                      ),
                      Container(
                        child: ReviewSlider(
                            onChange: (index) {
                                index==0?addflagprovider.imojeRate("Very Bad"):index==1?addflagprovider.imojeRate("Bad"):index==2?addflagprovider.imojeRate("Okay")
                                    :index==3?addflagprovider.imojeRate("Good"):index==4?addflagprovider.imojeRate("Great"):"";
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
