import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/models/Markers.dart';
import 'package:googlemaps/models/user.dart';
import 'package:provider/provider.dart';

class Store {
  Firestore firestore = Firestore.instance;
  adduser(User user) {
    firestore.collection(constants.usercollection).document(user.uid).setData({
      constants.username: user.username,
      constants.age: user.age,
      constants.uid: user.uid,
      constants.score: user.score
    });
  }
  updateScore(String uid,int scores){
    firestore.collection(constants.usercollection).document(uid).setData({
      constants.score:FieldValue.increment(scores)
    },merge: true);
  }
  addNarker(Markers markers,MarkerComments markerComments) {
    var time = DateTime.now();
    firestore.collection(constants.Markerscollection).document(time.toIso8601String()).setData({
      constants.placeName: markers.placename,

      constants.Location:markers.markerlocation,


    });
    firestore.collection(constants.Markerscollection).document(time.toIso8601String()).collection(constants.MarkersCommentscollection).document().setData({
      constants.uid: markerComments.owneruid,
      constants.Question1:markerComments.Question1,
      constants.Question2:markerComments.Question2,
      constants.placeRate:markerComments.PlaceRate,
      constants.time:markerComments.time,
      constants.Question3:markerComments.Question3,
      constants.Question4:markerComments.Question4,
      constants.Question5:markerComments.Question5,
      constants.Question6:markerComments.Question6,
      constants.Question7:markerComments.Question7,
      constants.Question8:markerComments.Question8,
      constants.Question9:markerComments.Question9,
      constants.Question10:markerComments.Question10,
      constants.Question11:markerComments.Question11,
      constants.Question12:markerComments.Question12,
      constants.Question13:markerComments.Question13,
      constants.Value4:markerComments.Value4,
      constants.Value5:markerComments.Value5,
      constants.Value6:markerComments.Value6,
      constants.Value7:markerComments.Value7,
      constants.Value8:markerComments.Value8,
      constants.Value9:markerComments.Value9,
      constants.Value10:markerComments.Value10,
      constants.Value11:markerComments.Value11,
      constants.Value12:markerComments.Value12,
      constants.Value13:markerComments.Value13,
      constants.Age:markerComments.Age,
      constants.Gender:markerComments.Gender

    });
  }
  addMarkerComment(String docId,MarkerComments markerComments){
    firestore.collection(constants.Markerscollection).document(docId).collection(constants.MarkersCommentscollection).document().setData({
      constants.uid: markerComments.owneruid,
      constants.Question1:markerComments.Question1,
      constants.Question2:markerComments.Question2,
      constants.placeRate:markerComments.PlaceRate,
      constants.time:markerComments.time,
      constants.Question3:markerComments.Question3,
      constants.Question4:markerComments.Question4,
      constants.Question5:markerComments.Question5,
      constants.Question6:markerComments.Question6,
      constants.Question7:markerComments.Question7,
      constants.Question8:markerComments.Question8,
      constants.Question9:markerComments.Question9,
      constants.Question10:markerComments.Question10,
      constants.Question11:markerComments.Question11,
      constants.Question12:markerComments.Question12,
      constants.Question13:markerComments.Question13,
      constants.Value4:markerComments.Value4,
      constants.Value5:markerComments.Value5,
      constants.Value6:markerComments.Value6,
      constants.Value7:markerComments.Value7,
      constants.Value8:markerComments.Value8,
      constants.Value9:markerComments.Value9,
      constants.Value10:markerComments.Value10,
      constants.Value11:markerComments.Value11,
      constants.Value12:markerComments.Value12,
      constants.Value13:markerComments.Value13,
      constants.Age:markerComments.Age,
      constants.Gender:markerComments.Gender
    });
  }


  adduserfacebook(User user, String uid) {
    firestore.collection(constants.usercollection).document(uid).setData({
      constants.username: user.username,
      constants.age: user.age,
      constants.uid: user.uid,
      constants.score: user.score
    });
  }
  updateFavouriteHeart (String userId,String docId,bool isFavourite,String placeName,GeoPoint location){
    firestore.collection(constants.Favouritecollection).document(userId).collection(constants.UserFavouritecollection).document(docId).setData({
      constants.IsFavourite:isFavourite,
      constants.uid:userId,
      constants.placeName:placeName,
      constants.Location:location,
      constants.time:docId

    });
  }
  Stream<QuerySnapshot> favouriteLike(String userId){
    return firestore.collection(constants.Favouritecollection).document(userId).collection(constants.UserFavouritecollection)
        .where(constants.uid,isEqualTo: userId).snapshots();
  }
  Stream<QuerySnapshot> favourite(String userId){
    return firestore.collection(constants.Favouritecollection).document(userId).collection(constants.UserFavouritecollection)
        .where(constants.IsFavourite,isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot> MarkersCommentStream(String documentId) {

    return firestore
        .collection(constants.Markerscollection).document(documentId).collection(constants.MarkersCommentscollection).orderBy(constants.time)
        .snapshots();
  }
  Stream<QuerySnapshot> MarkersStream() {

    return firestore
        .collection(constants.Markerscollection)
        .snapshots();
  }
  Stream<QuerySnapshot> MarkersStreamFav(String placeName) {

    return firestore
        .collection(constants.Markerscollection).where(constants.placeName,isEqualTo: placeName)
        .snapshots();
  }
  Stream<QuerySnapshot> UserInfo(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return firestore
        .collection(constants.usercollection)
        .where(constants.uid, isEqualTo: user.uid)
        .snapshots();
  }
  Stream<QuerySnapshot> UserInfowithid(String  id) {
    return firestore
        .collection(constants.usercollection)
        .where(constants.uid, isEqualTo: id)
        .snapshots();
  }
//  addMarker(Markers markers) {
//    firestore.collection(constants.usercollection).document().collection("collectionPath").document().setData({
//      constants.username: user.username,
//      constants.age: user.age,
//      constants.uid: user.uid,
//      constants.score: user.score
//    });
  // }
}
