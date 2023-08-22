// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
//
// class HomeMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mapbox Navigation Example'),
//       ),
//       body: Column(
//         children: [
//           // Display the map using the mapbox_gl package
//           Expanded(
//             child: MapboxMap(
//               accessToken: 'pk.eyJ1IjoidGVhbS1yb2d1ZSIsImEiOiJjbGxoaXF5azUwYm40M3BxdWw5bHF1ZXU0In0.AebPDjGi7PS2fLlYf65vPQ',
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(37.7749, -122.4194),
//                 zoom: 12.0,
//               ),
//             ),
//           ),
//           // Add a button to start navigation using the mapbox_navigation package
//           ElevatedButton(
//             onPressed: () async{
//
//           _distanceRemaining = await _directions.distanceRemaining;
//     _durationRemaining = await _directions.durationRemaining;
//
//     switch (e.eventType) {
//     case MapBoxEvent.progress_change:
//     var progressEvent = e.data as RouteProgressEvent;
//     _arrived = progressEvent.arrived;
//     if (progressEvent.currentStepInstruction != null)
//     _instruction = progressEvent.currentStepInstruction;
//     break;
//     case MapBoxEvent.route_building:
//     case MapBoxEvent.route_built:
//     _routeBuilt = true;
//     break;
//     case MapBoxEvent.route_build_failed:
//     _routeBuilt = false;
//     break;
//     case MapBoxEvent.navigation_running:
//     _isNavigating = true;
//     break;
//     case MapBoxEvent.on_arrival:
//     _arrived = true;
//     if (!_isMultipleStop) {
//     await Future.delayed(Duration(seconds: 3));
//     await _controller.finishNavigation();
//     } else {}
//     break;
//     case MapBoxEvent.navigation_finished:
//     case MapBoxEvent.navigation_cancelled:
//     _routeBuilt = false;
//     _isNavigating = false;
//     break;
//     default:
//     break;
//     },
//             child: Text('Start Navigation'),
//           ),
//         ],
//       ),
//     );
//   }
// }
