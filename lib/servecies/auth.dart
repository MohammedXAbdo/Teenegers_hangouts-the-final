import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlemaps/models/user.dart';

class Auth {

  final _auth = FirebaseAuth.instance;
  Future<AuthResult> sign_up_with_email_and_password(
      String Email, String Password) async {
    final authresult = await _auth.createUserWithEmailAndPassword(
        email: Email, password: Password);
    return authresult;
  }


  Future<AuthResult> sign_in_with_email_and_password(
      String Email, String Password) async {
    final authresult =
    await _auth.signInWithEmailAndPassword(email: Email, password: Password);
    return authresult;
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();

//  Future<String> signInWithGoogle() async {
//
//    return 'signInWithGoogle succeeded: $user';
//  }

//   Future<String> signInWithFacebook() async{
//
//  }

  Future signout() async{
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
    }
  }
  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}