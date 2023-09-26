import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class top extends StatefulWidget {
  const top({
    super.key,
  });

  @override
  State<top> createState() => _topState();
}

class _topState extends State<top> {
  var show = false;
  Query dbRef = FirebaseDatabase.instance.ref().child('quality');

  int whC = 30;
  var whS = "Mostly Cloudy";
  String? wisher;

  @override
  void initState() {
    super.initState();
    getWeather();
    DateTime datetime = DateTime.now();
    int hour = int.parse(DateFormat('HH').format(datetime));
    print(DateFormat('HH').format(datetime));
    if (hour >= 3 && hour < 12) {
      wisher = 'morning';
    } else if (hour >= 12 && hour < 18) {
      wisher = 'afternoon';
    } else if (hour >= 18 && hour < 24) {
      wisher = 'evening';
    } else {
      wisher = 'night';
    }
  }

  Future<void> getWeather() async {
    var cityName = "Chennai";
    var response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=e5f0de7f89494da8b3a90715232401&q=$cityName&aqi=yes'));

    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      whC = jsonData['current']['temp_c'].toInt();
      whS = jsonData['current']["condition"]['text'];
    } else {
      whC = 28;
      whS = "Mostly Cloudy";
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.account_circle,
                  size: width * 0.12,
                ),
                const SizedBox(
                  width: 6,
                ),
                Row(
                  children: [
                    Text(
                      "Good ",
                      style: TextStyle(
                        fontFamily: "SF-Pro",
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      wisher!,
                      style: TextStyle(
                        fontFamily: "SF-Pro",
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Stack(clipBehavior: Clip.none, children: [
              dropdown(
                "System 1",
                GestureDetector(
                  onTap: () => setState(() {
                    show = !show;
                  }),
                  child: Image(
                    image: AssetImage("assets/images/Icon.png"),
                  ),
                ),
              ),
              show
                  ? Positioned(
                      bottom: -40,
                      left: -2,
                      child: dropdown(
                        "Add Data",
                        Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 133, 132, 132),
                          size: 22,
                        ),
                      ),
                    )
                  : SizedBox()
            ]),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: height * 0.08,
              child: Image(
                image: AssetImage("assets/images/Cloud.png"),
                alignment: Alignment.topCenter,
              ),
            ),
            Text(
              "${whC}°C",
              style: const TextStyle(
                fontFamily: "SF-Pro",
                fontSize: 20,
              ),
            ),
            Text(
              whS,
              style: const TextStyle(
                fontFamily: "SF-Pro",
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dropdown(String name, Widget icon) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      padding: const EdgeInsets.only(left: 2, right: 12, top: 6, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromARGB(182, 255, 255, 255)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "SF-Pro",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          icon
        ],
      ),
    );
  }
}
