import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../charts/chart.dart';
import '../../theme/theme.dart';

class card2 extends StatelessWidget {
  const card2({
    super.key,
    required this.val,
    required this.header,
    required this.sider,
    required this.centerWidget,
    required this.footer,
  });

  final val;
  final String header;
  final String sider;
  final Widget centerWidget;
  final String footer;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => chart(
                sider: sider,
                last: val,
                wanted: header,
              ))),
      child: Container(
        width: width * 0.4,
        height: height * 0.225,
        decoration: BoxDecoration(
            color: !themeProvider.isDark ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text(
            header == 'TDS' ? 'SALINITY' : header.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              fontFamily: "SF-Pro",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          SizedBox(height: height * 0.14, child: centerWidget),
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  val.toString() + ' ' + sider,
                  style: const TextStyle(
                    fontFamily: "SF-Pro",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  footer,
                  style: const TextStyle(
                    fontFamily: "SF-Pro",
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
