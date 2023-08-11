import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' ;
// import 'package:location/location.dart' as lc;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// lc.Location _loc = lc.Location();
// late bool _permissiongranted;


  void initState() {
    super.initState();
    //_location();

  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    print(position);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Text('0')
      ),
    );
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
  _location() async{
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        height: 320,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/enableloc.png',
            height: 120,
              width: 120,
            ),
            SizedBox(height: 5,),
            Text('Enable location',style: TextStyle(fontSize: 20,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),

            Text('Choose your location to start find the',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(160, 160, 160, 1.0),fontSize: 12),),

            Text('request around you',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(160, 160, 160, 1.0),fontSize: 12),),
            SizedBox(height: 15,),
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
            SizedBox(height: 15,),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Text('Skip for now',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(255, 51, 51, 1.0)),),
            )

          ],
        ),
      )
    );

  });
  }

}
