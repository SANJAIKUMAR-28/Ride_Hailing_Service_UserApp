import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:velocito/pages/BookingProcess/Ride/RideOptions.dart';

import '../../../Models/polyline_response.dart';

class VehicleSelection extends StatefulWidget {
  final String from;
  final String to;
  final String distbtw;
  final String duration;
  final LatLng fromlatlon;
  final LatLng tolatlon;
  const VehicleSelection(
      {super.key, required this.from, required this.to, required this.distbtw, required this.duration, required this.fromlatlon, required this.tolatlon});

  @override
  State<VehicleSelection> createState() => _VehicleSelectionState();
}

class _VehicleSelectionState extends State<VehicleSelection> {
  final MapController _mapController = MapController();
  List<LatLng> routeGeometry = [];
  LocationData? currentLocation;
  void initState(){
    super.initState();
    fetchAndDisplayRoute();
  }
  void fetchAndDisplayRoute() async {
      final routeResponse = await _fetchRouteGeometry(
        widget.fromlatlon,
        widget.tolatlon,
      );

      if (routeResponse != null) {
        setState(() {
          routeGeometry = routeResponse;
        });
      }

  }
  Future<List<LatLng>?> _fetchRouteGeometry(LatLng start, LatLng end) async {
    const accessToken = 'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ'; // Replace with your Mapbox access token

    final response = await http.get(Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/${start
          .longitude},${start.latitude};${end.longitude},${end
          .latitude}?geometries=geojson&access_token=$accessToken',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];

      if (geometry != null) {
        final List<dynamic> coordinates = geometry['coordinates'];
        final routePoints = coordinates.map((coord) {
          final double lat = coord[1];
          final double lng = coord[0];
          return LatLng(lat, lng);
        }).toList();
        return routePoints;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Select vehicle',
            style: TextStyle(
                fontFamily: 'Arimo',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(62, 73, 88, 1.0)),
          ),
          centerTitle: true,
          toolbarHeight: 50,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: [
          FlutterMap(
            options: MapOptions(
              center: widget.fromlatlon,
              zoom: 13.0,
            ),
            mapController: _mapController,
            children: [
              TileLayer(
                urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ',
                additionalOptions: const {
                  'accessToken':
                  'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ',
                },
              ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeGeometry,
                      strokeWidth: 4,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: widget.fromlatlon,
                      builder: (ctx) =>
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: widget.tolatlon,
                      builder: (ctx) =>
                          Image.asset('assets/marker.png',height: 40,width: 40,),

                    ),
                  ],
                ),
              if (currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: LatLng(
                        currentLocation!.latitude!,
                        currentLocation!.longitude!,
                      ),
                      builder: (ctx) =>
                      const Icon(
                        Icons.my_location,
                        color: Colors.redAccent,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vehicle(
                            'assets/auto.png',
                            'VC Auto',
                            farecalc('Auto', widget.distbtw),
                            '3',
                            widget.distbtw),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                        ),
                        vehicle(
                            'assets/bike.png',
                            'VC Bike',
                            farecalc('Bike', widget.distbtw),
                            '1',
                            widget.distbtw),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                        ),
                        vehicle(
                            'assets/taxi4.png',
                            'VC Taxi 4 seats',
                            farecalc('Car4', widget.distbtw),
                            '4',
                            widget.distbtw),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                        ),
                        vehicle(
                            'assets/taxi7.png',
                            'VC Taxi 7 seats',
                            farecalc('Car7', widget.distbtw),
                            '7',
                            widget.distbtw),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ]));
  }

  Material vehicle(String asset, String name, String price,
      String seats, String distbtw) {
    return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: MaterialButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RideOptions(
                          img: asset,
                          cost: price,
                          vec: name,
                          seats: seats,
                          time: '3',
                          from: widget.from,
                          to: widget.to,
                          distbtw: distbtw, duration: widget.duration, fromlatlon: widget.fromlatlon, tolatlon: widget.tolatlon,
                        )));
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                "${asset}",
                height: 27,
                width: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Arimo',
                    color: Color.fromRGBO(0, 0, 0, 0.60),
                    fontWeight: FontWeight.bold),
              ),
            ]),
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Icon(
                    LineIcons.indianRupeeSign,
                    size: 13,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${price}',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            )
          ]),
        ));
  }



  String farecalc(String vec, String dist) {
    double fare = 0;
    if (vec == 'Auto') {
      fare = 20 + (double.parse(dist) * 10);
    }
    if (vec == 'Bike') {
      fare = 10 + (double.parse(dist) * 5);
    }
    if (vec == 'Car4') {
      fare = 30 + (double.parse(dist) * 15);
    }
    if (vec == 'Car7') {
      fare = 40 + (double.parse(dist) * 20);
    }
    return fare.toStringAsFixed(2);
  }
}
