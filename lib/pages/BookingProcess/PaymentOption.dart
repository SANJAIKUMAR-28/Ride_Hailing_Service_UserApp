import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/OnTheWay.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Payment option',
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
                      Image.asset('assets/map.png'),
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Select payment',
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(62, 73, 88, 1.0)),
                          ),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              shadowColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                                          "assets/gpay.png",
                                          height: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Gpay",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                                          "assets/card.png",
                                          height: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cards",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                              Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                splashColor: Colors.black.withOpacity(0.2),
                                onPressed: () {
                                Confirm();
                                },
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          "assets/cash.png",
                                          height: 27,
                                          width: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cash",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                              Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ]));
  }
  Confirm (){

    showDialog(context: context, builder: (context) {
      return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            height: 240,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle,
                  size: 95,
                  color: Color.fromRGBO(255, 51, 51, 0.8),
                ),
                SizedBox(height: 5,),
                Text('Booking Successfull',style: TextStyle(fontSize: 20,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),

                Text('Your boooking has been confirmed',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(160, 160, 160, 1.0),fontSize: 12),),

                Text('driver will pick you up soon',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(160, 160, 160, 1.0),fontSize: 12),),
                SizedBox(height: 23,),
                Divider(
                  color: Colors.black12,
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OnTheWay()));
                  },
                  child: Text('Done',style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(255, 51, 51, 1.0),fontSize: 16,fontWeight: FontWeight.bold),),
                )

              ],
            ),
          )
      );

    });
  }
}
