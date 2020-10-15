import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googlemaps/Provider/modelHud.dart';
import 'package:googlemaps/Screens/waitingWidget.dart';
import 'package:googlemaps/Widgets/customTextFormField.dart';
import 'package:googlemaps/Widgets/customtext.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/models/user.dart';
import 'package:googlemaps/servecies/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:googlemaps/Screens/home.dart';
import 'package:googlemaps/servecies/store.dart';
class signup extends StatelessWidget {
  static String id  = 'signup';
   String _name,_email,_password;
  final _auth = Auth();
   int _age;
   final store  = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      child: Scaffold(
        backgroundColor: constants.whitecolor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<modelHud>(context).isloading,
          child: Form(
            key: _globalKey,
            child: Stack(
              children: <Widget>[
                SvgPicture.asset(
                  constants.backgoungimage,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: height,
                    width: width,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          child: Container(
                            width: width*0.2,
                            child: SvgPicture.asset(constants.icon),
                          ),
                        ),
                        //text
                        Center(
                            child: customText(
                                fontWeight: FontWeight.bold,
                                textcolor: constants.blackcolor,
                                size: 20,
                                text: "Teenagers Hangouts")),
                        //text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Container(
                                child: customText(
                                  text: "Your Way ",
                                  fontWeight: FontWeight.normal,
                                  textcolor: constants.blackcolor,
                                  size: 13,
                                )),
                          ),
                        ),
                        //text
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: Center(
                              child: FittedBox(
                                child: customText(
                                    fontWeight: FontWeight.bold,
                                    textcolor: constants.blackcolor,
                                    size: 20,
                                    text: "Sign Up"),

                              )

                          ),
                        ),
                        //custom text field for username
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          child: customTextFormField(hint: "User Name",iconData: Icons.account_circle,onclick: (value){
                            _name = value;
                          },),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          child: customTextFormField(hint: "Email",iconData: Icons.email,onclick: (value){
                            _email = value;
                          }),
                        ),
                        //custom text for password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          child: customTextFormField(hint: "Password",iconData: Icons.vpn_key,onclick: (value){
                            _password = value;
                          }),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                          child: customTextFormField(hint: "Age",iconData: Icons.sentiment_neutral,onclick: (value){
                            _age = int.parse(value);
                          }),
                        ),
                        //login button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          child: Builder(
                            builder: (context)=> FlatButton(
                              padding: EdgeInsets.all(15),
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                              onPressed: () async {
                               final modelhud= Provider.of<modelHud>(context,listen: false);
                               if(_globalKey.currentState.validate()) {
                                 _globalKey.currentState.save();
                                 modelhud.isprogressloding(true);
                                 try {
                                   final authResult = await _auth
                                       .sign_up_with_email_and_password(
                                       _email, _password);
                                   modelhud.isprogressloding(false);
                                   store.adduser(User(_name, _age, authResult.user.uid));
                                   Navigator.pushNamed(context, waitngWidget.id);
                                   print(authResult.user.uid);
                                 }on PlatformException catch(e){
                                   Scaffold.of(context).showSnackBar(SnackBar(
                                     content: Text(
                                       e.message.toString(),
                                       style: TextStyle(fontFamily: 'font'),
                                     ),
                                   ));
                                   modelhud.isprogressloding(false);
                                 }
                               }
                               modelhud.isprogressloding(false);
                              },
                              color: constants.primarycolor,

                              child: customText(text: "Sign Up",textcolor: constants.blackcolor,size: 19,),
                            ),
                          ),
                        ),

                      ],

                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
