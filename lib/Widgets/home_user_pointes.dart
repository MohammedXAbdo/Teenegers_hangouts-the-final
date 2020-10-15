import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/custom_icons/custom_icons.dart';

class home_user_pointes extends StatelessWidget {
  const home_user_pointes({
    Key key,
    @required this.width,
    @required this.height,
    this.username, this.colllectedpointes,
  }) : super(key: key);
  final int colllectedpointes;
  final double width;
  final double height;
  final String username;

  @override
  Widget build(BuildContext context) {
    Store  store = Store();
    return StreamBuilder(
      stream: store.UserInfo(context),
      builder: (context , snapshot) {
        if(snapshot.hasData) {
          return Container(
            width: width,
            height: height * 0.15,
            color: constants.whitecolor,
            child: LayoutBuilder(
              builder: (context, constrains) =>
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: constrains.maxHeight * 0.1,
                      ),
                      Container(
                        height: constrains.maxHeight * 0.57,
                        width: constrains.maxWidth * 0.95,
                        color: constants.purblecolor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(

                                children: <Widget>[
                                  Container(
                                      width: constrains.maxWidth * 0.15,
                                      child: SvgPicture.asset(
                                          "images/profile.svg")),
                                  SizedBox(width: constrains.maxWidth * 0.05,),
                                  Container(
                                    width: constrains.maxWidth * 0.7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Container(
                                                width: constrains.maxWidth *
                                                    0.33,
                                                child: AutoSizeText(
                                                  snapshot.hasData == false
                                                      ? "User Name"
                                                      : snapshot.data
                                                      .documents[0][constants
                                                      .username]==null?"User Name": snapshot.data
                                                      .documents[0][constants
                                                      .username],
                                                  style: TextStyle(
                                                      fontFamily: 'font',
                                                      color: constants
                                                          .blackcolor,
                                                      fontSize: 15),
                                                  maxLines: 1,
                                                  maxFontSize: 15,
                                                  minFontSize: 9,
                                                  softWrap: true,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              AutoSizeText(
                                                snapshot.data
                                                    .documents[0][constants
                                                    .score]<100?"Junior Hero":
                                                snapshot.data
                                                    .documents[0][constants
                                                    .score]>100&&snapshot.data
                                                    .documents[0][constants
                                                    .score]<200?"Senior Hero":
                                                snapshot.data
                                                    .documents[0][constants
                                                    .score]>200?"Master Hero":
                                                "Junior Hero",
                                                style: TextStyle(
                                                    fontFamily: 'font',
                                                    color: constants.blackcolor,
                                                    fontSize: 12),
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  10),
                                              color: constants.graycolor),
                                          width: constrains.maxWidth * 0.3,
                                          height: constrains.maxHeight * 0.3,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                  width: constrains.maxWidth *
                                                      0.02),
                                              Icon(
                                                Custom_icons.coins,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                  width: constrains.maxWidth *
                                                      0.01),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: AutoSizeText(
                                                      "Collected Pointes",
                                                      style: TextStyle(
                                                          fontFamily: 'font',
                                                          color: Colors.white,
                                                          fontSize: 7),
                                                      maxLines: 1,
                                                      minFontSize: 3,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    snapshot.hasData == false
                                                        ? "0"
                                                        : "${ snapshot.data
                                                        .documents[0][constants
                                                        .score]}",
                                                    style: TextStyle(
                                                        fontFamily: 'font',
                                                        color: Colors.white,
                                                        fontSize: 7),
                                                    softWrap: true,
                                                    minFontSize: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          );
        }else
          return Center(child:Text("Loading....",style: TextStyle(fontFamily: 'font'),));

      }
    );
  }
}
