import 'package:flutter/material.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Ride history',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                historyBox('COMPLETED'),
                historyBox('CANCELLED'),
              ],
            )),
      ),
    );
  }

  Padding historyBox(String sts) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '8 JUNE 2023, 18:45',
                        style: TextStyle(
                            fontFamily: 'Arimo', fontWeight: FontWeight.w600),
                      ),
                      ('${sts}' == 'COMPLETED')
                          ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700))
                          : Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700))
                    ]),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.black12,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '18:45',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                              ),
                            ),
                            Text('19:00',
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color.fromRGBO(255, 51, 51, 0.8),
                              size: 10,
                            ),
                            Container(
                              height: 60,
                              child: VerticalDivider(
                                color: Colors.black54,
                                thickness: 2,
                                indent: 2,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '59/Amman Street',
                              style: TextStyle(
                                  fontFamily: 'Arimo', color: Colors.grey),
                            ),
                            Text(
                              'Tirupur,641603 hgyfutddttfydtfgfyf cfutugu Bit',
                              style: TextStyle(
                                  fontFamily: 'Arimo', color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                    ],
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
