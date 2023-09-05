import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/Ride/RideOptions.dart';

import '../../../Models/polyline_response.dart';

class VehicleSelection extends StatefulWidget {
  final String from;
  final String to;
  final String distbtw;
  final String duration;
  final String fromlatlon;
  final String tolatlon;
  const VehicleSelection(
      {super.key, required this.from, required this.to, required this.distbtw, required this.duration, required this.fromlatlon, required this.tolatlon});

  @override
  State<VehicleSelection> createState() => _VehicleSelectionState();
}

class _VehicleSelectionState extends State<VehicleSelection> {
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
                            '0.67 km',
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
                            '0.79 km',
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
                            '0.5 km',
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
                            '1.67 km',
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

  Material vehicle(String asset, String name, String price, String dist,
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
                          dist: dist,
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
                Text(
                  '${dist}',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Arimo',
                    color: Color.fromRGBO(0, 0, 0, 0.60),
                  ),
                ),
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
