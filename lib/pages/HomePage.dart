import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:velocito/pages/BookingProcess/LocationSelector.dart';

import '../Models/user_model.dart';
// import 'package:location/location.dart' as lc;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// lc.Location _loc = lc.Location();
// late bool _permissiongranted;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late String name = '';
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        name = loggedInUser.name!;
      });
      //_location();
    });
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(255, 245, 245, 1),
                  child: Icon(
                    Icons.person,
                    color: Color.fromRGBO(242, 96, 96, 1),
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Arimo',
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(78, 16, 16, 1)),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ]),
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          shadowColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(255, 245, 245, 1),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text('Are you ready for a',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black)),
                            Text('Smooth ride?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text('Sit back,relax and enjoy the ride',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black26)),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 140,
                              height: 30,
                              child: Material(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(255, 51, 51, 0.7),
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LocationSelector()));
                                  },
                                  child: Text(
                                    "Ride with Velo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Arimo',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/homecar.png',
                          height: 140,
                          width: 140,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select a ride',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
                    Text('')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationSelector()));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(245, 245, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Image.asset(
                              'assets/ridecar.png',
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ride',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(245, 245, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Image.asset(
                              'assets/intercitycar.png',
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Intercity',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(245, 245, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Image.asset(
                              'assets/officecar.png',
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Office',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ));
  }

// Future<void> _requestLocationPermission() async {
//   _permissiongranted = (await _loc.hasPermission()) as bool;
//   if (_permissiongranted == PermissionStatus.denied) {
//    _location();
//     if (_permissiongranted != PermissionStatus.granted) {
//       return; // Permission not granted, handle accordingly
//     }
//   }
// }
  _location() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/enableloc.png',
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Enable location',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Choose your location to start find the',
                      style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Color.fromRGBO(160, 160, 160, 1.0),
                          fontSize: 12),
                    ),
                    Text(
                      'request around you',
                      style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Color.fromRGBO(160, 160, 160, 1.0),
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 51, 51, 0.9),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Navigator.of(context).pop();
                          getLocation();
                        },
                        child: Text(
                          "Use my location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Arimo',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Skip for now',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(255, 51, 51, 1.0)),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
