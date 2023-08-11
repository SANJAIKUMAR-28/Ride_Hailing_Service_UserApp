import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class VehicleSelection extends StatefulWidget {
  const VehicleSelection({super.key});

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
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Image.asset('assets/map.png')
                    ],
                  ),
                ),
              ),
              SizedBox(
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
                          vehicle('assets/auto.png','VC Auto','80.76','0.67 km'),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.5,
                          ),
                          vehicle('assets/bike.png','VC Bike','97.98','0.79 km'),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.5,
                          ),
                          vehicle('assets/taxi4.png','VC Taxi 4 seats','104.76','0.5 km'),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.5,
                          ),
                          vehicle('assets/taxi7.png','VC Taxi 7 seats','156.45','1.67 km'),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.5,
                          )

                        ],
                      ),
                    )),
              ),
            ],
          ),
        ]));
  }

  Material vehicle(String asset,String name,String price,String dist){
    return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          splashColor: Colors.black.withOpacity(0.2),
          onPressed: () {},
          child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
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
                        color:
                        Color.fromRGBO(0, 0, 0, 0.60),
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Icon(LineIcons.indianRupeeSign,size: 13,color: Colors.black,),
                    SizedBox(width: 2,),
                    Text('${price}',style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        color:
                        Colors.black,
                        fontWeight: FontWeight.bold),),
                    ]
                    ),
                    Text('${dist}',style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arimo',
                        color:
                        Color.fromRGBO(0, 0, 0, 0.60),
                        ),),
                  ],
                )
              ]),
        ));
  }
}
