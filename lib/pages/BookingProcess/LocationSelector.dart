import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';
import 'package:http/http.dart' as http;

import 'Ride/DriverDetails.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  LatLng? startLocation;
  LatLng? endLocation;
  String routeDistance='';
  String routeDuration='';
  bool currentLocationMaker= true;
  LocationData? currentLocation;
  final MapController _mapController = MapController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<LatLng> routeGeometry = [];

  @override
  void initState() {
    super.initState();
    _getLocation(); // Get current location when the app starts
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getLocation() async {
    final location = Location();
    try {
      final locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

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

  void fetchAndDisplayRoute() async {
    if (startLocation != null && endLocation != null) {
      final routeResponse = await _fetchRouteGeometry(
        startLocation!,
        endLocation!,
      );

      if (routeResponse != null) {
        setState(() {
          routeGeometry = routeResponse;
        });
        _calculateRouteInfo();
      }
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Select location',
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
      body:  currentLocation != null
          ? Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center:LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
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
                if (routeGeometry.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routeGeometry,
                        strokeWidth: 4,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                if (startLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 30.0,
                        height: 30.0,
                        point: startLocation!,
                        builder: (ctx) =>
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                if (endLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: endLocation!,
                        builder: (ctx) =>
                            Image.asset('assets/marker.png',height: 40,width: 40,),

                      ),
                    ],
                  ),
                if (currentLocation != null && currentLocationMaker)
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
              top: 100,
              left: 20,
              right: 20,
              child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 12, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _startController,
                                  style: TextStyle(fontFamily: 'Arimo'),
                                  decoration:
                                  const InputDecoration(
                                    border: InputBorder.none,
                                      labelText:'From' ,
                                      labelStyle:TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w500) ,
                                      ),
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
                                    title: Text(suggestion.toString(),style: TextStyle(fontFamily: 'Arimo',fontSize: 12)),
                                  );
                                },
                                onSuggestionSelected: (suggestion) async {
                                  setState(() {
                                    _startController.text = suggestion;
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
                            ),
                            IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: () {
                                if (currentLocation != null) {
                                  setState(() {
                                    startLocation = LatLng(
                                        currentLocation!.latitude!,
                                        currentLocation!.longitude!);
                                    _startController.text = "Current Location";
                                  });
                                  currentLocationMaker=false;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding:const EdgeInsets.fromLTRB(15, 0, 12, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _destinationController,
                                  style: TextStyle(fontFamily: 'Arimo'),
                                  decoration:
                                  const InputDecoration(
                                    border: InputBorder.none,
                                    labelText:'To' ,
                                    labelStyle:TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.w500) ,),
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
                                    _destinationController.text = suggestion;
                                  });
                                  final location =
                                  await suggestionToLatLng(suggestion);
                                  if (location != null) {
                                    setState(() {
                                      endLocation = location;
                                    });
                                  }
                                  fetchAndDisplayRoute();
                                  if (startLocation != null) {
                                    _mapController.move(
                                      LatLng(startLocation!.latitude,
                                          startLocation!.longitude),
                                      13.0, // Zoom level
                                    );
                                  } //
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: () {
                                if (currentLocation != null) {
                                  setState(() {
                                    endLocation = LatLng(
                                        currentLocation!.latitude!,
                                        currentLocation!.longitude!);
                                    _destinationController.text =
                                    "Current Location";
                                  });
                                  currentLocationMaker=false;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            if(routeDuration!='')
            Positioned(
                bottom: 100,
                left: 20,
                child: Card(
                  elevation: 1,
              child:Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(LineIcons.road,color: Colors.redAccent,),
                        SizedBox(width: 5,),
                        Text('Distance : $routeDistance km',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(LineIcons.clock,color: Colors.redAccent,),
                        SizedBox(width: 5,),
                        Text('Est. time : $routeDuration',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
              ) ,
            )),
            Positioned(
              bottom: 30,
              right: 20,
              left: 20,
              child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 2,
              color: Color.fromRGBO(255, 51, 51, 0.9),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehicleSelection(
                            from: _startController.text,
                            to: _destinationController.text,
                            distbtw: routeDistance, duration: routeDuration, fromlatlon: startLocation!, tolatlon: endLocation!,
                          )));
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
            ),)
          ]
      ):Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.redAccent,),
          SizedBox(height: 10,),
          Text('Fetching current location...Please wait',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey[500]),)
        ],
      )),
    );
  }
}
