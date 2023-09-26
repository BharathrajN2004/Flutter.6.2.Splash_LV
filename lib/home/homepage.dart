import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pqmlightversion/home/helper/flask.dart';

import './helper/top.dart';
import 'package:flutter/material.dart';

import 'helper/circular.dart';
import 'helper/linear.dart';
import 'helper/phind.dart';
import 'widget/card1.dart';
import 'widget/card2.dart';

class home extends StatelessWidget {
  home({super.key});

  Query dbRef = FirebaseDatabase.instance.ref().child('quality');
// FirebaseDatabase.instance.ref("quality/2-push").onValue
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: width * 0.05, left: width * 0.08, right: width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              top(),
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref("DO Value").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final found = double.parse(snapshot
                          .data!.snapshot.children.last.value
                          .toString());
                      var oxyI;
                      if (found >= 5 && found <= 11) {
                        oxyI = "Optimum";
                      } else if (found > 11) {
                        oxyI = "High";
                      } else if (found < 5) {
                        oxyI = "Low";
                      } else {
                        oxyI = "";
                      }
                      return card1(
                          header: "oxygen level",
                          displayVal: found,
                          sideText: "ppm",
                          footer: oxyI,
                          sidewidget:
                              flask(value: double.parse(found.toString())));
                    } else {
                      return SizedBox();
                    }
                  }),
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref("pH Value").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final found = double.parse(snapshot
                          .data!.snapshot.children.last.value
                          .toString());
                      String phI;
                      if (found > 6.5 && found <= 7.5) {
                        phI = "Neutral";
                      } else if (found > 7.5 && found <= 8.5) {
                        phI = "Optimum";
                      } else if (found > 5.5 && found < 6.5) {
                        phI = "Slightly acidic";
                      } else if (found <= 5.5) {
                        phI = "Acidic";
                      } else if (found > 8.5) {
                        phI = "Basic";
                      } else {
                        phI = "Error";
                      }
                      return card1(
                        header: "ph level",
                        displayVal: found,
                        sideText: "",
                        footer: phI,
                        sidewidget: phind(
                          value: found,
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
              StreamBuilder(
                  stream: FirebaseDatabase.instance.ref("TEMP Value").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final found = double.parse(snapshot
                          .data!.snapshot.children.last.value
                          .toString());
                      var tempI;
                      if (found >= 25 && found <= 35) {
                        tempI = "Optimum";
                      } else if (found > 35) {
                        tempI = "High";
                      } else if (found < 25) {
                        tempI = "Low";
                      } else {
                        tempI = "Error";
                      }
                      return card1(
                          header: "temperature",
                          displayVal: found,
                          sideText: "°C",
                          footer: tempI,
                          sidewidget: linearIndicator(temp: found / 50.0));
                    } else {
                      return SizedBox();
                    }
                  }),
              SizedBox(
                height: height * 0.001,
              )
            ],
          ),
        ),
      ),
    );
  }
}
