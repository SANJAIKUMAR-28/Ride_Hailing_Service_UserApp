import 'package:flutter/material.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';

import 'Ride/DriverDetails.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({super.key});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final fromcontroller = new TextEditingController();
  final tocontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final from = Material(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: fromcontroller,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Pick FROM location");
            }
            return null;
          },
          onSaved: (value) {
            fromcontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.circle_outlined,
                color: Color.fromRGBO(255, 51, 51, 0.9),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Choose pick up point",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final to = Material(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: tocontroller,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Pick TO location");
            }
            return null;
          },
          onSaved: (value) {
            tocontroller.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color:Color.fromRGBO(255, 51, 51, 0.9),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Choose your destionation",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [Image.asset('assets/map.png')],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 320,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Where are you going?',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(62, 73, 88, 1.0)),
                            ),
                            Text('')
                          ],
                        ),
                        Column(
                          children:[
                        from,
                        SizedBox(height: 15,),
                        to,
                        ]
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 2,
                          color: Color.fromRGBO(255, 51, 51, 0.9),
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => VehicleSelection()));
                            },
                            child:  Text(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
