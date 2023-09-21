import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/Dailies/DailiesDetails.dart';

class Dailies extends StatefulWidget {
  const Dailies({super.key});

  @override
  State<Dailies> createState() => _DailiesState();
}

class _DailiesState extends State<Dailies> {
  final fromcontroller = new TextEditingController();
  final tocontroller = new TextEditingController();
  LatLng? startLocation;
  LatLng? endLocation;
  String routeDistance='';
  String routeDuration='';
  final departureController = new TextEditingController();
  final returnController = new TextEditingController();
  final departuretimeController = new TextEditingController();
  final returntimeController = new TextEditingController();
  bool Monday=false;
  bool Sunday=false;
  bool Tuesday=false;
  bool Wednesday=false;
  bool Friday=false;
  bool Saturday=false;
  bool Thursday=false;
  Future<List<String>> fetchLocationSuggestions(String query) async {
    const accessToken =
        'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ'; // Replace with your Mapbox access token
    final endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$accessToken';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List<dynamic>;
      final suggestions =
      features.map((feature) => feature['place_name'] as String).toList();
      return suggestions;
    } else {
      throw Exception('Failed to load location suggestions');
    }
  }

  Future<LatLng?> suggestionToLatLng(String suggestion) async {
    const accessToken =
        'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ'; // Replace with your Mapbox access token
    final endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$suggestion.json?access_token=$accessToken';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List<dynamic>;
      if (features.isNotEmpty) {
        final coordinates = features[0]['geometry']['coordinates'] as List<
            dynamic>;
        final latitude = coordinates[1] as double;
        final longitude = coordinates[0] as double;
        return LatLng(latitude, longitude);
      }
    }

    return null;
  }
  void _calculateRouteInfo() async {
    if (startLocation != null && endLocation != null) {
      const accessToken =
          'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ'; // Replace with your Mapbox access token

      final response = await http.get(Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/${startLocation!.longitude},${startLocation!.latitude};${endLocation!.longitude},${endLocation!.latitude}?geometries=geojson&access_token=$accessToken',
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final distance = data['routes'][0]['distance'];
        final durationInSeconds = data['routes'][0]['duration'];

        final hours = (durationInSeconds / 3600).floor();
        final minutes = ((durationInSeconds % 3600) / 60).floor();

        setState(() {
          routeDistance = '${(distance / 1000).toStringAsFixed(2)}';
          routeDuration = '${hours}h ${minutes}m';
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final from = Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
              borderRadius: BorderRadius.circular(10)),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: fromcontroller,
              style: TextStyle(fontFamily: 'Arimo'),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isNotEmpty) {
                return await fetchLocationSuggestions(
                    pattern);
              } else {
                return [];
              }
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                visualDensity: VisualDensity(horizontal: 0,vertical: -4),
                title: Text(suggestion.toString(),style: TextStyle(fontFamily: 'Arimo',fontSize: 12),),
              );
            },
            onSuggestionSelected: (suggestion) async {
              setState(() {
                fromcontroller.text = suggestion;
              });
              final location =
              await suggestionToLatLng(suggestion);
              if (location != null) {
                setState(() {
                  startLocation = location;
                });
              }

            },
          ),
        ));
    final to = Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
              borderRadius: BorderRadius.circular(10)),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: tocontroller,
              style: TextStyle(fontFamily: 'Arimo'),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isNotEmpty) {
                return await fetchLocationSuggestions(
                    pattern);
              } else {
                return [];
              }
            },

            itemBuilder: (context, suggestion) {
              return ListTile(
                visualDensity: VisualDensity(horizontal: 0,vertical: -4),
                title: Text(suggestion.toString(),style: TextStyle(fontFamily: 'Arimo',fontSize: 12),),
              );
            },
            onSuggestionSelected: (suggestion) async {
              setState(() {
                tocontroller.text = suggestion;
              });
              final location =
              await suggestionToLatLng(suggestion);
              if (location != null) {
                setState(() {
                  endLocation = location;
                });
              }
              _calculateRouteInfo();
            },
          ),
        ));
    final departure = SizedBox(
      width: 145,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              cursorColor: Colors.redAccent,
              autofocus: false,
              controller: departureController,
              style: TextStyle(
                fontFamily: 'Arimo',
              ),
              keyboardType: TextInputType.phone,
              onTap: () async {
                DateTime? pickdate2 = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 0)),
                    lastDate: DateTime(2050));

                if (pickdate2 != null) {
                  setState(() {
                    departureController.text =
                        DateFormat('dd/MM/yyyy').format(pickdate2);
                  });
                }
                ;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Pick TO location");
                }
                return null;
              },
              onSaved: (value) {
                departureController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    LineIcons.calendar,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
          )),
    );
    final todate = SizedBox(
      width: 145,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              cursorColor: Colors.redAccent,
              autofocus: false,
              controller: returnController,
              style: TextStyle(fontFamily: 'Arimo'),
              keyboardType: TextInputType.phone,
              onTap: () async {
                DateTime? pickdate2 = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 0)),
                    lastDate: DateTime(2050));

                if (pickdate2 != null) {
                  setState(() {
                    returnController.text =
                        DateFormat('dd/MM/yyyy').format(pickdate2);
                  });
                }
                ;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Pick TO location");
                }
                return null;
              },
              onSaved: (value) {
                returnController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    LineIcons.calendar,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
          )),
    );

    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Dailies',
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
        body: SingleChildScrollView(
          child: Stack(clipBehavior: Clip.none, children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(255, 245, 245, 1),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 640 ,
                  child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'From',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                from,
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'To',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                to,
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'From date',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        departure,
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'To date',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        todate,
                                      ],
                                    )
                                  ],
                                ),
                                Return(),
                                SizedBox(height: 15,),
                                Text(
                                  'Exceptions',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5,),
                                Card(
                                  elevation: 0,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                      child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context).size.width)/2,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      splashColor:Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap:(){
                                                        setState(() {
                                                          Sunday=!Sunday;
                                                        });
                                                      },
                                                      child: (Sunday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                  SizedBox(width: 5,),
                                                  Text('Sunday',style: TextStyle(fontFamily: 'Arimo'),),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                    splashColor:Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap:(){
                                                      setState(() {
                                                        Thursday=!Thursday;
                                                      });
                                                    },
                                                    child: (Thursday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                SizedBox(width: 5,),
                                                Text('Thursday',style: TextStyle(fontFamily: 'Arimo'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context).size.width)/2,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                  splashColor:Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap:(){
                                                        setState(() {
                                                          Monday=!Monday;
                                                        });
                                                      },
                                                      child: (Monday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                  SizedBox(width: 5,),
                                                  Text('Monday',style: TextStyle(fontFamily: 'Arimo'),),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                    splashColor:Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap:(){
                                                      setState(() {
                                                        Friday=!Friday;
                                                      });
                                                    },
                                                    child: (Friday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                SizedBox(width: 5,),
                                                Text('Friday',style: TextStyle(fontFamily: 'Arimo'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context).size.width)/2,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      splashColor:Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap:(){
                                                        setState(() {
                                                          Tuesday=!Tuesday;
                                                        });
                                                      },
                                                      child: (Tuesday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                  SizedBox(width: 5,),
                                                  Text('Tuesday',style: TextStyle(fontFamily: 'Arimo'),),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                    splashColor:Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap:(){
                                                      setState(() {
                                                        Saturday=!Saturday;
                                                      });
                                                    },
                                                    child: (Saturday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                SizedBox(width: 5,),
                                                Text('Saturday',style: TextStyle(fontFamily: 'Arimo'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                    splashColor:Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap:(){
                                                      setState(() {
                                                        Wednesday=!Wednesday;
                                                      });
                                                    },
                                                    child: (Wednesday)?Icon(Icons.check_box,color: Colors.redAccent,size: 18,):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: 18,)),
                                                SizedBox(width: 5,),
                                                Text('Wednesday',style: TextStyle(fontFamily: 'Arimo'),),
                                              ],
                                            ),
                                            Text('')
                                          ],
                                        ),
                                      ],
                                ),
                                    ),
                                  ),),
                                SizedBox(height: 20,),
                                Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(255, 51, 51, 0.9),
                                  child: MaterialButton(
                                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => DailiesDetails(from: fromcontroller.text, to: tocontroller.text, fromdate: departureController.text, pickuptime: departuretimeController.text, todatedate: returnController.text, repickuptime: returntimeController.text, dist: routeDistance, est: routeDuration, totaldays: dayscalc(departureController.text, returnController.text),)));
                                    },
                                    child: Text(
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
                              ])))),
            )
          ]),
        ));
  }
  Column Return() {

    final departuretime = SizedBox(
      width: 145,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              cursorColor: Colors.redAccent,
              autofocus: false,
              controller: departuretimeController,
              style: TextStyle(
                fontFamily: 'Arimo',
              ),
              keyboardType: TextInputType.phone,
              onTap: () async {
                TimeOfDay? picktime2 = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    });
                if (picktime2 != null) {
                  setState(() {
                    departuretimeController.text = picktime2.format(context);
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please select FROM time");
                }
                return null;
              },
              onSaved: (value) {
                departuretimeController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    LineIcons.clock,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
          )),
    );
    final returntime = SizedBox(
      width: 145,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              cursorColor: Colors.redAccent,
              autofocus: false,
              controller: returntimeController,
              style: TextStyle(
                fontFamily: 'Arimo',
              ),
              keyboardType: TextInputType.phone,
              onTap: () async {
                TimeOfDay? picktime2 = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: false),
                        child: child!,
                      );
                    });
                if (picktime2 != null) {
                  setState(() {
                    returntimeController.text = picktime2.format(context);
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please select FROM time");
                }
                return null;
              },
              onSaved: (value) {
                returntimeController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    LineIcons.clock,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  border: InputBorder.none),
            ),
          )),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Pickup time',
                style:
                TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              departuretime,
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Re-pickup time',
                style:
                TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              returntime,
            ]),
          ],
        )
      ],
    );
  }
  String dayscalc(String fromday,String today){
    String days='';
    days=((int.parse(today.substring(0,2)))-(int.parse(fromday.substring(0,2)))+1).toString();
    return days;
  }
}
