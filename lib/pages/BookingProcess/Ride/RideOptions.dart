import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:velocito/pages/BookingProcess/Ride/DriverDetails.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../Models/user_model.dart';

class RideOptions extends StatefulWidget {
  final String img;
  final String cost;
  final String vec;
  final String seats;
  final String time;
  final String from;
  final String to;
  final String distbtw;
  final String duration;
  final LatLng fromlatlon;
  final LatLng tolatlon;
  const RideOptions(
      {super.key,
      required this.img,
      required this.cost,
      required this.vec,
      required this.seats,
      required this.time,
      required this.from,
      required this.to,
      required this.distbtw, required this.duration, required this.fromlatlon, required this.tolatlon});

  @override
  State<RideOptions> createState() => _RideOptionsState();
}

class _RideOptionsState extends State<RideOptions> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Requests');
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
  String? sts;
  late String date;
  late String fromtime;
  late String totime;
  final MapController _mapController = MapController();
  List<LatLng> routeGeometry = [];
  LocationData? currentLocation;
  @override
  void initState() {
    super.initState();
    fetchAndDisplayRoute();
    DateTime dateTime = DateTime.now();
    String day = "${dateTime.day}";
    String month = "${dateTime.month}";
    String year = "${dateTime.year}";
    date = datefunc(day, month, year);
    fromtime = "${dateTime.hour}:${dateTime.minute}";
    String est = duration(widget.duration);
    totime = TimeEstimation(fromtime, est);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    _userRef = FirebaseDatabase.instance.ref().child('Requests');
    sts = '';
    _userRef.child(user!.uid).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          sts = data['STATUS'];
        });
      }
    });
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
            'Ride options',
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
              height: 320,
              child: Selection(),
            ),
          ),
        ]));
  }

  Material Selection() {
    return Material(
        elevation: 5,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VehicleSelection(
                                              from: widget.from,
                                              to: widget.to,
                                              distbtw: widget.distbtw, duration: widget.duration, fromlatlon: widget.fromlatlon, tolatlon: widget.tolatlon,
                                            )));
                              },
                              child: Text(
                                'Change',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: Color.fromRGBO(255, 51, 51, 0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "${widget.img}",
                                  height: 50,
                                  width: 80,
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'Total cost : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  LineIcons.indianRupeeSign,
                                  size: 13,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${widget.cost}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.vec}',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                              ),
                            ),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Color.fromRGBO(255, 51, 51, 0.8),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${widget.seats} seats',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Color.fromRGBO(255, 51, 51, 0.8),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  '3 mins',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Estimated trip time',
                    style: TextStyle(
                        fontFamily: 'Arimo', color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    ' ${widget.duration}',
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Color.fromRGBO(255, 51, 51, 0.8),
                        fontSize: 13),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 2,
                color: Color.fromRGBO(255, 51, 51, 0.9),
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    Map<String, String> Requests = {
                      'FROM': widget.from,
                      'TO': widget.to,
                      'FROM-LAT':'${widget.fromlatlon.latitude}',
                      'FROM-LON':'${widget.fromlatlon.longitude}',
                      'TO-LAT':'${widget.tolatlon.latitude}',
                      'TO-LON':'${widget.fromlatlon.longitude}',
                      'VEHICLE': widget.vec,
                      'COST': widget.cost,
                      'PASSENGER-NAME': '${loggedInUser.name}',
                      'PASSENGER-NUMBER': '${loggedInUser.phoneno}',
                      'STATUS': 'REQUESTED',
                      'PASSENGER-STATUS': 'INITIATED',
                      'PASSENGER-ID': '${loggedInUser.uid}',
                      'SEATS': widget.seats,
                      'TIME': widget.time,
                      'FROM-TIME': fromtime,
                      'TO-TIME': totime,
                      'DATE': date,
                      'value':'1',
                    };
                    dbRef.child('${loggedInUser.uid}').set(Requests);

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              content: Container(
                                  height: 600,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              InkWell(
                                                  child: lottie.Lottie.asset(
                                                      "assets/searching.json"),
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () {
                                                    print(sts);
                                                  }),
                                              Image.asset(
                                                "assets/loadcar.png",
                                                height: 80,
                                                width: 50,
                                              ),
                                            ]),
                                        SizedBox(
                                          height: 250,
                                        ),
                                        Text(
                                          "Searching for a driver",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Arimo',
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ])));
                        });
                    //
                    checksts();
                  },
                  child: Text(
                    "Book ride",
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
        ));
  }

  checksts() {
    Timer(Duration(seconds: 1), () async {
      if (sts == "ACCEPTED") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DriverDetails()));
      } else {
        return checksts();
      }
    });
  }

  String datefunc(String day, String mnth, String year) {
    String date = '';
    String month = '';
    if (mnth == '1' || mnth == '01') {
      month = 'JANUARY';
    } else if (mnth == '2' || mnth == '02') {
      month = 'FEBRUARY';
    } else if (mnth == '3' || mnth == '03') {
      month = 'MARCH';
    } else if (mnth == '4' || mnth == '04') {
      month = 'APRIL';
    } else if (mnth == '5' || mnth == '05') {
      month = 'MAY';
    } else if (mnth == '6' || mnth == '06') {
      month = 'JUNE';
    } else if (mnth == '7' || mnth == '07') {
      month = 'JULY';
    } else if (mnth == '8' || mnth == '08') {
      month = 'AUGUST';
    } else if (mnth == '9' || mnth == '09') {
      month = 'SEPTEMBER';
    } else if (mnth == '10') {
      month = 'OCTOBER';
    } else if (mnth == '11') {
      month = 'NOVEMBER';
    } else {
      month = 'DECEMBER';
    }
    date = '${day} ' + '${month} ' + year;
    return date;
  }

  String TimeEstimation(String from, String est) {
    String estimatedTime = '';
    if (int.parse(est) > 0 && int.parse(est) < 60) {
      int index = from.indexOf(':');
      String min = from.substring(index + 1);
      estimatedTime = from.substring(0, index + 1) +
          (int.parse(min) + int.parse(est)).toString();
    }
    return estimatedTime;
  }
  String duration(String duration){
    String est='';
    int hrindex= duration.indexOf('h');
    int minindex=duration.indexOf(' ')+1;
    int minindex2=duration.indexOf('m');
    int hr = int.parse(duration.substring(0,hrindex));
    int min = int.parse(duration.substring(minindex,minindex2));
    int esttime=(hr*60)+min;
    return esttime.toString();
  }
}
