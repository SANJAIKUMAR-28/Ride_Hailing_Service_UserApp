import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
                      SizedBox(
                        height: 50,
                      ),
                      Text('hi'),
                      SizedBox(
                        height: 500,
                      ),
                      Text('hoo'),
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
                              elevation: 1,
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
                              elevation: 1,
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
                              elevation: 1,
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
}
