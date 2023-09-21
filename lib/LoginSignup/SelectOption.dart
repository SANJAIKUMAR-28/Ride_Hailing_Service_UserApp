import 'package:flutter/material.dart';
import 'package:velocito/LoginSignup/Login.dart';
import 'package:velocito/LoginSignup/MobileLogin.dart';

class SelectOption extends StatefulWidget {
  const SelectOption({super.key});

  @override
  State<SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/phnemailimg.png",
                height: 180,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Make Connects\nwith Velocito',
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'To your dream trip',
                style: TextStyle(fontSize: 20, fontFamily: 'Arimo'),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileLogin()));
                      },
                      child: Text(
                        "Login with mobile no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Arimo',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login with email ID",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(255, 51, 51, 0.9),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
