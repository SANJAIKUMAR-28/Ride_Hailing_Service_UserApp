import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InitialMap extends StatefulWidget {
  const InitialMap({super.key});

  @override
  State<InitialMap> createState() => _InitialMapState();
}

class _InitialMapState extends State<InitialMap> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.497452335156774, 77.2769906825176),
    zoom: 14.4746,
  );
  late String _mapStyle;
  late GoogleMapController mapController;
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          mapController.setMapStyle(_mapStyle);
    },
      )
    );
  }
}
