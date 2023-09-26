import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../helper/back.dart';
import '../theme/theme.dart';

class chart extends StatefulWidget {
  chart(
      {super.key,
      required this.wanted,
      required this.last,
      required this.sider});
  final String wanted;
  final String sider;
  final last;

  @override
  State<chart> createState() => _chartState();
}

class _chartState extends State<chart> {
  String timestan = 'hour';
  var time = '8:30 PM';

  late ChartSeriesController controller;
  String? path;
  @override
  Widget build(BuildContext context) {
    if (widget.wanted == 'ph level') {
      path = 'pH Value';
    } else if (widget.wanted == 'oxygen level') {
      path = 'DO Value';
    } else if (widget.wanted == 'temperature') {
      path = "TEMP Value";
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context);
    Color color = themeProvider.isDark ? Colors.white : Colors.black;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              top: height * 0.01, left: width * 0.02, right: width * 0.02),
          child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref(path).onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final list = snapshot.data!.snapshot.children.toList();
                List li = [];
                if (timestan == 'day') {
                  li = [];
                  int length = list.length;
                  for (var index = 0; index < 10; index++) {
                    double sum = 0;
                    for (var i = 1; i < 25; i++) {
                      sum += double.parse(list[length - i].value.toString());
                    }
                    li.add([index, (sum / 24)]);
                    length -= 25;
                  }
                } else {
                  li = [];
                  for (var index = 1; index < 25; index++) {
                    li.add(
                      [
                        index,
                        double.parse(list[list.length - index].value.toString())
                      ],
                    );
                  }
                }
                print(li);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    back(width: width),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.015),
                      alignment: Alignment.center,
                      child: Text(
                        widget.wanted == 'TDS'
                            ? 'SALINITY'
                            : widget.wanted.toUpperCase(),
                        style: TextStyle(
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    shifter(width, height, color, themeProvider.isDark),
                    lastvalue(width, height, li[0][1], widget.sider),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.04),
                      child: Text(
                        'STATS',
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.015),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              textStyle: TextStyle(color: color),
                              tooltipPosition: TooltipPosition.auto,
                              builder: (data, point, series, pointIndex,
                                  seriesIndex) {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    data[1].toStringAsFixed(2),
                                    style: TextStyle(color: color),
                                  ),
                                );
                              },
                            ),
                            series: <ChartSeries>[
                              ColumnSeries<dynamic, num>(
                                borderRadius: BorderRadius.circular(6),
                                enableTooltip: true,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 82, 177, 255),
                                      Color.fromARGB(255, 0, 140, 255)
                                    ]),
                                dataSource: li,
                                xValueMapper: (i, _) {
                                  return i[0];
                                },
                                yValueMapper: (i, _) {
                                  return i[1];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        bottomButton(width, 'View Previous Data'),
                        bottomButton(width, 'Download Previous Data'),
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                  child: LoadingAnimationWidget.beat(
                    color: color,
                    size: 200,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Container bottomButton(double width, String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Color.fromARGB(255, 190, 190, 190),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.03,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Container lastvalue(double width, double height, double last, var unit) {
    return Container(
      width: width,
      margin: EdgeInsets.only(
          top: height * 0.05,
          left: width * 0.04,
          right: width * 0.04,
          bottom: height * 0.05),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Value : ${last.toStringAsFixed(2)} ${unit}',
            style:
                TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          SizedBox(
            height: height * 0.01,
          ),
        ],
      ),
    );
  }

  Center shifter(double width, double height, Color data, theme) {
    return Center(
        child: Container(
            width: width * 0.625,
            margin: EdgeInsets.only(
              top: height * 0.02,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 232, 232),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    timestan = 'hour';
                  }),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: width * 0.01,
                          left: width * 0.01,
                          bottom: width * 0.01),
                      decoration: BoxDecoration(
                          color: timestan == 'hour' ? data : Colors.transparent,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(width * 0.025),
                      child: Text(
                        'Last 24 hours',
                        style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    timestan = 'day';
                  }),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: width * 0.01,
                        right: width * 0.01,
                        bottom: width * 0.01),
                    decoration: BoxDecoration(
                        color: timestan == 'day' ? data : Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(width * 0.025),
                    child: Text(
                      'Last 10 days',
                      style: TextStyle(
                          fontSize: width * 0.04, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            )));
  }
}
