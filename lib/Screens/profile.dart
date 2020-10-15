
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googlemaps/Provider/modelHud.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:googlemaps/Widgets/customTextFormField.dart';
import 'package:googlemaps/custom_icons/custom_icons.dart';
import 'package:googlemaps/servecies/auth.dart';
import 'package:googlemaps/servecies/store.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:googlemaps/constants.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  IconData arrow = Icons.keyboard_arrow_down;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Auth auth = Auth();
    Store  store = Store();
    var password;
    return StreamBuilder(
      stream: store.UserInfo(context),
      builder: (context,snapshot) {
        if(snapshot.hasData) {
        return  ModalProgressHUD(
            inAsyncCall: Provider
                .of<modelHud>(context)
                .isloading,
            child: Form(
              key: _globalKey,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(child: SvgPicture.asset("images/profile.svg")),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Text(
                        snapshot.hasData == false ? "" : snapshot.data
                            .documents[0][constants.username],
                        style: TextStyle(
                            fontFamily: 'font', fontSize: width * 0.04),
                      ),
                      Text(
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
                            fontFamily: 'font', fontSize: width * 0.03),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.2)
                              ]),
                          child: ExpansionTile(
                            leading: Icon(
                              Custom_icons.coins,
                              size: 40,
                            ),
                            title: Text(
                              snapshot.hasData == false ? "0" : "${snapshot.data
                                  .documents[0][constants.score]} Points",
                              style: TextStyle(fontFamily: 'font'),
                            ),
                            subtitle: Text(
                              "Get More Points and Choose Your Prize",
                              style: TextStyle(
                                  fontFamily: 'font', fontSize: 12),
                            ),
                            trailing: Text(""),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.2)
                              ]),
                          child: ExpansionTile(
                            leading: Icon(
                              Custom_icons.profile,
                              size: 40,
                            ),
                            title: Text(
                              "Basic Information",
                              style: TextStyle(fontFamily: 'font'),
                            ),
                            subtitle: Text(
                              "Edit Your Information",
                              style: TextStyle(
                                  fontFamily: 'font', fontSize: 12),
                            ),
                            trailing: Icon(arrow),
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "User Name",
                                            style: TextStyle(
                                                fontFamily: 'font'),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            child: customTextFormField(
                                              hint: snapshot.hasData == false
                                                  ? ""
                                                  : snapshot.data
                                                  .documents[0][constants
                                                  .username],
                                              iconData: Icons.account_circle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.015,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Age",
                                            style: TextStyle(
                                                fontFamily: 'font'),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            child: customTextFormField(
                                              hint: snapshot.hasData == false ||
                                                  snapshot.data
                                                      .documents[0][constants
                                                      .age] == null
                                                  ? ""
                                                  : "${snapshot.data
                                                  .documents[0][constants
                                                  .age]}",
                                              iconData: Icons.sentiment_neutral,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.015,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Email",
                                            style: TextStyle(
                                                fontFamily: 'font'),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            child: customTextFormField(
                                              hint:
                                              Provider
                                                  .of<FirebaseUser>(context)
                                                  .email ==
                                                  null ?
                                              ""
                                                  : Provider
                                                  .of<FirebaseUser>(context)
                                                  .email,

                                              iconData: Icons.mail,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.2)
                              ]),
                          child: ExpansionTile(

                            onExpansionChanged: (bool iss){
                              print (iss);
                            },
                            leading: Icon(
                              Custom_icons.lock,
                              size: 40,
                            ),
                            title: Text(
                              "Password",
                              style: TextStyle(fontFamily: 'font'),
                            ),
                            subtitle: Text(
                              "Edit Your Password",
                              style: TextStyle(
                                  fontFamily: 'font', fontSize: 12),
                            ),
                            trailing: Icon(arrow),
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Password",
                                            style: TextStyle(
                                                fontFamily: 'font'),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            child: customTextFormField(

                                              hint: 'Password',
                                              iconData: Icons.lock,
                                              onclick: (value) {
                                                password = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.015,

                                      ),
                                      Center(
                                        child: Builder(
                                          builder: (context) =>
                                              FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  color: constants.primarycolor,
                                                  onPressed: () {
                                                    final modelhud = Provider
                                                        .of<
                                                        modelHud>(
                                                        context, listen: false);
                                                    modelhud.isprogressloding(
                                                        true);
                                                    if (_globalKey.currentState
                                                        .validate()) {
                                                      _globalKey.currentState
                                                          .save();
                                                      _changePassword(
                                                          password, modelhud);
                                                    } else {
                                                      modelhud.isprogressloding(
                                                          false);
                                                    }
                                                  },
                                                  child: Text(
                                                    "change your password!",
                                                    style: TextStyle(
                                                        fontFamily: 'font'),)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            var user = Provider.of<FirebaseUser>(
                                context, listen: false);
                            print(user.uid);
                            auth.signout();
                            if (user == null) {
                              Phoenix.rebirth(context);
                              Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(waitngWidget.id));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 0.2)
                                ]),
                            child: ListTile(
                              leading: Icon(
                                Icons.exit_to_app,
                                size: 40,
                              ),
                              title: Text(
                                "Logout",
                                style: TextStyle(fontFamily: 'font'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.22,
                  ),
                ],
              ),
            ),
          );
        }else

        return Center(child:Text("Loading...."));
      }

    );
  }
  void _changePassword(String password,modelHud modelHud) async{
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      modelHud.isprogressloding(false);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Password Updated you Should Login Again",
      style: TextStyle(fontFamily: 'font'),)));
      print("Succesfull changed password");
    }).catchError((error){
      modelHud.isprogressloding(false);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Password can't be changed${error.toString()}",
        style: TextStyle(fontFamily: 'font'),)));
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
