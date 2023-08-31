import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:velocito/Maps/InitialMap.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';

import 'Ride/DriverDetails.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final fromcontroller = new TextEditingController();
  final tocontroller = new TextEditingController();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.497452335156774, 77.2769906825176),
    zoom: 14.4746,
  );
  late String _mapStyle;
  late GoogleMapController mapController;
Future<String> ShowPlaces() async {
  const kGoogleApiKey = "AIzaSyB5DetvY563NyKXiVeydE1spiQgSAg1zrk";

  Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      offset: 0,
      radius: 1000,
      types: ["(cities)"],
      region: "us",
      strictbounds: false,
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
      hintText: 'Search location',
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
  borderSide: BorderSide(
  color: Colors.white,
  ),
  ),
  ),
  components: [Component(Component.country, "us")],
  );
  return "Hi";

}
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  @override
  Widget build(BuildContext context) {
    final from = Material(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          //readOnly: true,
          // onTap: () async {
          //     String? selectedplace = await ShowPlaces();
          //     fromcontroller.text=selectedplace;
          // },
          autofocus: false,
          controller: fromcontroller,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Pick FROM location");
            }
            return null;
          },
          onSaved: (value) {
            fromcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.circle_outlined,
                color: Color.fromRGBO(255, 51, 51, 0.9),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Choose pick up point",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final to = Material(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: tocontroller,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Pick TO location");
            }
            return null;
          },
          onSaved: (value) {
            tocontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color:Color.fromRGBO(255, 51, 51, 0.9),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Choose your destionation",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController.setMapStyle(_mapStyle);
            },
          ),
          Positioned(
            bottom: 0,
            child:
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(62, 73, 88, 1.0)),
                        ),
                        Text('')
                      ],
                    ),
                    Column(
                      children:[
                    from,
                    SizedBox(height: 15,),
                    to,
                    ]
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 2,
                      color: Color.fromRGBO(255, 51, 51, 0.9),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => VehicleSelection(from: fromcontroller.text, to: tocontroller.text, distbtw: '10.36',)));
                        },
                        child:  Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Arimo',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
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
    );
  }
}
