import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlemaps/constants.dart';
class customTextFormField extends StatelessWidget {
  String hint;
  IconData iconData;

  Function onclick;
  customTextFormField({
    @required this.hint ,@required this.iconData,
     this.onclick,
    Key key,
  }) : super(key: key);
  String errorMassage(String str){
    switch(hint){
      case "User Name" :return "User Name Is Empty";
      case "Email" :return "Email Is Empty";
      case "Password" :return "Password Is Empty";
      case "Age" :return "Age Is Empty";
      default : return "value is empty";
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if (value.isEmpty){
          return errorMassage(hint);
        }

      },
      keyboardType: hint =="Age"?TextInputType.number:hint =="Email"?TextInputType.emailAddress:TextInputType.text,
      onSaved: onclick,
      obscureText: hint=="Password"?true:false,
      cursorColor: constants.primarycolor,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
              ,borderSide: BorderSide(color: constants.primarycolor)
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
              ,borderSide: BorderSide(color: constants.primarycolor)
          ) ,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
              ,borderSide: BorderSide(color: constants.primarycolor)
          ) ,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(iconData,color: constants.primarycolor,),
          hintText: hint,
          hintStyle: TextStyle(fontFamily: 'font')
      ),
    );
  }
}