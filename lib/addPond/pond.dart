import 'dart:math';

import 'package:flutter/material.dart';

class pond extends StatefulWidget {
  const pond({super.key});

  @override
  State<pond> createState() => _pondState();
}

class _pondState extends State<pond> {
  bool expanded = false;
  String fixedPond = 'pond1';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.transparent),
        height: height,
        width: width,
        padding: EdgeInsets.only(
            top: height * 0.05, left: width * 0.08, right: width * 0.08),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Add Pond',
                style: TextStyle(
                    fontSize: width * 0.08, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              tiles(
                height,
                width,
                'pond1',
              ),
              tiles(height, width, 'pond2'),
              tiles(height, width, 'pond3'),
              tiles(height, width, 'pond4'),
            ],
          ),
        ),
      ),
    );
  }

  bool expand = false;
  Widget tiles(double height, double width, String pond) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.04),
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 204, 204, 204), width: 2),
          borderRadius: BorderRadius.circular(14)),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        collapsedBackgroundColor: Colors.white,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              pond,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: height * 0.006,
            ),
            expand
                ? const SizedBox()
                : Container(
                    margin: EdgeInsets.only(bottom: height * 0.01),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 211, 211, 211)),
                    child: Text(
                      'More Detail',
                      style: TextStyle(
                          fontSize: width * 0.035,
                          color: const Color.fromARGB(255, 54, 54, 54)),
                    ),
                  ),
            // Text("dbkh")
          ],
        ),
        onExpansionChanged: (value) {
          print(value);
          setState(() {
            expand = value;
          });
        },
        collapsedTextColor: Colors.black,
        trailing: fixedPond != pond
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    fixedPond = pond;
                  });
                },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0)),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 165, 165, 169))),
                onHover: (value) {},
                child: Text(
                  'Switch',
                  style: TextStyle(
                    fontSize: width * 0.04,
                  ),
                ),
              )
            : Container(
                margin:
                    EdgeInsets.only(top: height * 0.01, right: width * 0.04),
                child: Text(
                  'Active',
                  style: TextStyle(
                      color: Color.fromARGB(255, 91, 91, 91),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600),
                ),
              ),
        children: [
          const element(
            maintext: "Pond Size: ",
            subtext: "1500 sq ft",
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const element(
            maintext: 'No. of systems: ',
            subtext: '3',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin:
                    EdgeInsets.only(right: width * 0.04, bottom: height * 0.01),
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 102, 102, 104),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class element extends StatelessWidget {
  final String maintext;
  final String subtext;

  const element({super.key, required this.maintext, required this.subtext});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: width * 0.04),
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: [
            TextSpan(
                text: maintext,
                style: TextStyle(
                    color: const Color.fromARGB(255, 58, 58, 58),
                    fontWeight: FontWeight.w700,
                    fontSize: width * 0.048)),
            TextSpan(
                text: subtext,
                style: TextStyle(
                    color: const Color.fromARGB(255, 141, 141, 141),
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.0425)),
          ],
        ),
      ),
    );
  }
}
