import 'package:flutter/material.dart';

class TripEnded extends StatefulWidget {
  const TripEnded({super.key});

  @override
  State<TripEnded> createState() => _TripEndedState();
}

class _TripEndedState extends State<TripEnded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child:

        SizedBox(
          height: 500,
          width: 300,
          child: Material(
            color: Color.fromRGBO(196, 196, 196, 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.check,
                    color: Color.fromRGBO(255, 51, 51, 0.7),
                    size: 45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
