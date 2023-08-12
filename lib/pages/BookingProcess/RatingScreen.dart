import 'package:flutter/material.dart';
import 'package:velocito/pages/BookingProcess/TripEnded.dart';

import 'PaymentOption.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final Message = new TextEditingController();
  int val=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Send feedback',
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
        body: Column(
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
            Stack(
                clipBehavior: Clip.none,
                children:<Widget> [
                  SingleChildScrollView(
                    child:
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 450,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                child: Divider(
                                  thickness: 3,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5,right: 5),
                                          child: Text('TN 39 BR 1446',style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('Volkswagen Jeta',style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black54,
                                          fontSize: 14
                                      ))
                                    ],
                                  )
                                ],
                              ),
                             SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                      setState(() {
                                        val=1;
                                      });
                                   },
                                    child:
                                    (val>0)?
                                  Icon(Icons.star,color: Color.fromRGBO(255, 51, 51, 0.9),size: 30,):Icon(Icons.star,color: Colors.grey,size: 30,),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                        setState(() {
                                          val=2;
                                        });
                                    },
                                    child:
                                    (val>1)?
                                    Icon(Icons.star,color: Color.fromRGBO(255, 51, 51, 0.9),size: 30,):Icon(Icons.star,color: Colors.grey,size: 30,),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                      setState(() {
                                        val=3;
                                      });
                                    },
                                    child:
                                    (val>2)?
                                    Icon(Icons.star,color: Color.fromRGBO(255, 51, 51, 0.9),size: 30,):Icon(Icons.star,color: Colors.grey,size: 30,),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                    setState(() {
                                      val=4;
                                    });
                                    },
                                    child:
                                    (val>3)?
                                    Icon(Icons.star,color: Color.fromRGBO(255, 51, 51, 0.9),size: 30,):Icon(Icons.star,color: Colors.grey,size: 30,),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:(){
                                    setState(() {
                                      val=5;
                                    });
                                    },
                                    child:
                                    (val>4)?
                                    Icon(Icons.star,color: Color.fromRGBO(255, 51, 51, 0.9),size: 30,):Icon(Icons.star,color: Colors.grey,size: 30,),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              if(val==0)
                              Text('Very Poor',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              if(val==1)
                                Text('Poor',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              if(val==2)
                                Text('Moderate',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              if(val==3)
                                Text('Good',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              if(val==4)
                                Text('Very Good',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              if(val==5)
                                Text('Excellent',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(height: 20,),
                              SizedBox(height: 150,
                              child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(196, 196, 196, 0.1),
                                  child: TextFormField(
                                    textAlign:  TextAlign.left,
                                    maxLines: null,
                                    autofocus: false,
                                    controller: Message,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    style: TextStyle(fontFamily: 'Arimo'),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Please enter your feedback");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      Message.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        hintText: "Message",
                                        hintStyle: TextStyle(fontFamily: 'Arimo',),
                                        border: InputBorder.none),
                                  )
                              ),
                              ),
                              SizedBox(height: 20,),
                              Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => TripEnded()));
                                  },
                                  child:  Text(
                                    "Finish",
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
                      )),
                          ),
                  Positioned(
                    top: -40,
                    child:
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child:
                            CircleAvatar(
                              radius: 40,
                              child:Image.asset('assets/driver.png'),)
                        ),
                        Text('Prithvi',style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16
                        ))
                      ],
                    ),
                  ),

                ]
            ),
          ],
        )
    );;
  }
}
