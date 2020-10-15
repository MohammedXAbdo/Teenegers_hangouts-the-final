import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:googlemaps/Provider/AddFlagProvider.dart';
import 'package:googlemaps/constants.dart';
import 'package:googlemaps/models/Markers.dart';
import 'package:provider/provider.dart';
class add_location_widget extends StatefulWidget {
 final double width;
  final double height;

   add_location_widget({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  static LatLng _lastMapPosition = LatLng(30.033333, 31.233334);

  @override
  _add_location_widgetState createState() => _add_location_widgetState();
}

class _add_location_widgetState extends State<add_location_widget> {
  GoogleMapController googleMapController;
  List<Marker> markers=[];

  void _OnMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }
  String place = "Click To Add Your Place...";

  @override
  Widget build(BuildContext context) {
    final addflagprovider = Provider.of<Addflagprovider>(context);
    return  Container(
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
            height: widget.height * 0.1,
            child: GestureDetector(
              onTap: () async {
                Prediction p =
                await PlacesAutocomplete.show(
                    context: context,
                    apiKey: constants.kGoogleApiKey,
                    mode: Mode
                        .overlay, // Mode.fullscreen
                    language: "Ar",
                    onError: (e) {
                      print(
                          "error:${e.errorMessage}");
                    },
                    components: [
                      new Component(
                          Component.country, "Eg")
                    ]);


                  GoogleMapsPlaces _places = new GoogleMapsPlaces(
                      apiKey: constants.kGoogleApiKey); //Same API_KEY as above
                  PlacesDetailsResponse detail =
                  await _places.getDetailsByPlaceId(p.placeId);
                  double latitude = detail.result.geometry.location.lat;
                  double longitude = detail.result.geometry.location.lng;
                  String address = p.description;
                  googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(latitude, longitude), zoom: 17, bearing: 90)));
                         addflagprovider.getaddress(address);





              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: 1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_location,
                        color: constants.primarycolor,
                      ),
                      Flexible(
                          child: Text(
                            Provider.of<Addflagprovider>(context,listen: false).adress1==null?place:Provider.of<Addflagprovider>(context,listen: false).adress1,
                            style: TextStyle(
                                fontFamily: 'font'),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              markers: Set.from(markers),
              mapType: MapType.normal,
              onMapCreated: _OnMapCreated,
              initialCameraPosition: CameraPosition(
                  target: add_location_widget._lastMapPosition, zoom: 20),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (LatLng latLng) {
                print(latLng.toString());
                setState(() {
                  markers = [];
                  markers.add(Marker(
                      markerId: MarkerId(latLng.toString()),
                      position: latLng));
                });
                addflagprovider.getlatlang(latLng.latitude, latLng.longitude);
              },

            ),
          ),
        ],
      ),
    );
  }


}