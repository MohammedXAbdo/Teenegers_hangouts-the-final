import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';
import 'package:googlemaps/constants.dart';
import 'package:provider/provider.dart';
import 'package:reviews_slider/reviews_slider.dart';
class QuestionsImojeSlider extends StatefulWidget {
  const QuestionsImojeSlider({
    Key key,
    @required this.width,
    @required this.height, this.Question1, this.Question2, this.Question3, this.pagenumber,
  }) : super(key: key);
   final int pagenumber;
  final double width;
  final double height;
  final String Question1;
  final String Question2;
  final String Question3;


  @override
  _getQuestionsState createState() => _getQuestionsState();
}

class _getQuestionsState extends State<QuestionsImojeSlider> {

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
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              color: constants.whitecolor,
            ),
            height: widget.height * 0.05,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey,
                          width: 1))),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Flexible(
                      child: Center(
                        child: Text(
                        " Answer Questions Please",
                          style:
                          TextStyle(fontFamily: 'font'),
                        ),
                      ))),
            ),
          ),
          Expanded(child: Container(

            child: Column(
              children: <Widget>[

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
                            AutoSizeText(widget.Question1,style: TextStyle(
                                fontFamily: 'font'
                            ),softWrap: true,maxLines: 1,
                              maxFontSize: 12,

                              minFontSize: 8,),
                            Container(

                              child: ReviewSlider(


                                  options: ['Strongly disagree','Disagree','none','agree','Strongly agree'],
                                  onChange: (index) {
                                    if (widget.pagenumber==1){
                                      index==0?addflagprovider.question4Result("Strongly disagree"):index==1?addflagprovider.question4Result("Disagree"):index==2?addflagprovider.question4Result("none")
                                          :index==3?addflagprovider.question4Result("agree"):index==4?addflagprovider.question4Result("Strongly agree"):"";
                                      index==0?addflagprovider.value4Result(1):index==1?addflagprovider.value4Result(2):index==2?addflagprovider.value4Result(0)
                                          :index==3?addflagprovider.value4Result(3):index==4?addflagprovider.value4Result(4):0;
                                    }else if (widget.pagenumber==2){
                                      index==0?addflagprovider.question7Result('Strongly disagree'):index==1?addflagprovider.question7Result("Disagree"):index==2?addflagprovider.question7Result("none")
                                          :index==3?addflagprovider.question7Result("agree"):index==4?addflagprovider.question7Result("Strongly agree"):"";
                                      index==0?addflagprovider.value7Result(1):index==1?addflagprovider.value7Result(2):index==2?addflagprovider.value7Result(0)
                                          :index==3?addflagprovider.value7Result(3):index==4?addflagprovider.value7Result(4):0;
                                    }else if (widget.pagenumber==3){
                                      index==0?addflagprovider.question10Result("Strongly disagree"):index==1?addflagprovider.question10Result("Disagree"):index==2?addflagprovider.question10Result("none")
                                          :index==3?addflagprovider.question10Result("agree"):index==4?addflagprovider.question10Result("Strongly agree"):"";
                                      index==0?addflagprovider.value10Result(1):index==1?addflagprovider.value10Result(2):index==2?addflagprovider.value10Result(0)
                                          :index==3?addflagprovider.value10Result(3):index==4?addflagprovider.value10Result(4):0;
                                    }


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
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(widget.Question2,style: TextStyle(
                              fontFamily: 'font'
                            ),softWrap: true,maxLines: 1,  maxFontSize: 12,

                              minFontSize: 8,),

                            Container(

                              child: ReviewSlider(
                                  options: ['Strongly disagree','Disagree','none','agree','Strongly agree'],
                                  onChange: (index) {
                                    if (widget.pagenumber==1){
                                      index==0?addflagprovider.question5Result("Strongly disagree"):index==1?addflagprovider.question5Result("Disagree"):index==2?addflagprovider.question5Result("none")
                                          :index==3?addflagprovider.question5Result("agree"):index==4?addflagprovider.question5Result("Strongly agree"):"";
                                      index==0?addflagprovider.value5Result(1):index==1?addflagprovider.value5Result(2):index==2?addflagprovider.value5Result(0)
                                          :index==3?addflagprovider.value5Result(3):index==4?addflagprovider.value5Result(4):0;
                                    }else if (widget.pagenumber==2){
                                      index==0?addflagprovider.question8Result("Strongly disagree"):index==1?addflagprovider.question8Result("Disagree"):index==2?addflagprovider.question8Result("Disagree")
                                          :index==3?addflagprovider.question8Result("agree"):index==4?addflagprovider.question8Result("Strongly agree"):"";
                                      index==0?addflagprovider.value8Result(1):index==1?addflagprovider.value8Result(2):index==2?addflagprovider.value8Result(0)
                                          :index==3?addflagprovider.value8Result(3):index==4?addflagprovider.value8Result(4):0;
                                    }else if (widget.pagenumber==3){
                                      index==0?addflagprovider.question11Result("Strongly disagree"):index==1?addflagprovider.question11Result("Disagree"):index==2?addflagprovider.question11Result("none")
                                          :index==3?addflagprovider.question11Result("agree"):index==4?addflagprovider.question11Result("Strongly agree"):"";
                                      index==0?addflagprovider.value11Result(1):index==1?addflagprovider.value11Result(2):index==2?addflagprovider.value11Result(0)
                                          :index==3?addflagprovider.value11Result(3):index==4?addflagprovider.value11Result(4):0;
                                    }
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

                    child: Center(
                      child:Container(
                        padding: EdgeInsets.symmetric(vertical:2),
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(widget.Question3,style: TextStyle(
                                fontFamily: 'font'
                            ),softWrap: true,maxLines: 1,
                            maxFontSize: 12,
                            minFontSize: 8,),
                            Container(

                              child: ReviewSlider(
                                  options: ['Strongly disagree','Disagree','none','agree','Strongly agree'],
                                  onChange: (index) {
                                    if (widget.pagenumber==1){
                                      index==0?addflagprovider.question6Result("Strongly disagree"):index==1?addflagprovider.question6Result("Disagree"):index==2?addflagprovider.question6Result("none")
                                          :index==3?addflagprovider.question6Result("agree"):index==4?addflagprovider.question6Result("Strongly agree"):"";
                                      index==0?addflagprovider.value6Result(1):index==1?addflagprovider.value6Result(2):index==2?addflagprovider.value6Result(0)
                                          :index==3?addflagprovider.value6Result(3):index==4?addflagprovider.value6Result(4):0;

                                    }else if (widget.pagenumber==2){
                                      index==0?addflagprovider.question9Result("Strongly disagree"):index==1?addflagprovider.question9Result("Disagree"):index==2?addflagprovider.question9Result("none")
                                          :index==3?addflagprovider.question9Result("agree"):index==4?addflagprovider.question9Result("Strongly agree"):"";
                                      index==0?addflagprovider.value9Result(1):index==1?addflagprovider.value9Result(2):index==2?addflagprovider.value9Result(0)
                                          :index==3?addflagprovider.value9Result(3):index==4?addflagprovider.value9Result(4):0;
                                    }else if (widget.pagenumber==3){
                                      index==0?addflagprovider.question12Result("Strongly disagree"):index==1?addflagprovider.question12Result("Disagree"):index==2?addflagprovider.question12Result("none")
                                          :index==3?addflagprovider.question12Result("agree"):index==4?addflagprovider.question12Result("Strongly agree"):"";
                                      index==0?addflagprovider.value12Result(1):index==1?addflagprovider.value12Result(2):index==2?addflagprovider.value12Result(0)
                                          :index==3?addflagprovider.value12Result(3):index==4?addflagprovider.value12Result(4):0;
                                    }
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
          )),
        ],
      ),
    );
  }
}
