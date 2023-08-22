import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class InitialMap extends StatefulWidget {
  const InitialMap({super.key});

  @override
  State<InitialMap> createState() => _InitialMapState();
}

class _InitialMapState extends State<InitialMap> {

  late MapboxMap _mapboxMap;

  @override
  void initState() {
    super.initState();
    _mapboxMap = MapboxMap(
      //styleString: "mapbox://styles/team-rogue/cllm9n52v01gu01pb5e2740vq",
      accessToken: 'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ',
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(11.49074, 77.27644),
        zoom: 11.0,
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    // You can interact with the map controller here
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mapbox Map in Flutter'),
        ),
        body: Center(
          child:  _mapboxMap,
        ),
      ),
    );
  }
}
