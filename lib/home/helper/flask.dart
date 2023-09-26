import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';
import 'painters.dart';

class flask extends StatelessWidget {
  flask({super.key, required this.value});
  final value;
  Size kSize = Size(60, 60);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: Center(
        child: Stack(
          children: <Widget>[
            CustomPaint(
              size: kSize / 6,
              painter: FlaskPainter(
                  themeProvider.isDark ? Colors.black : Colors.white),
            ),
            CustomPaint(
              size: kSize / 5,
              painter: ReflectionPainter(
                  themeProvider.isDark ? Colors.black : Colors.white,
                  themeProvider.isDark ? Colors.black : Colors.white),
            ),
            Container(
              height: 56,
              width: 73,
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: LiquidCircularProgressIndicator(
                value: value / 20,
                valueColor: value > 6 && value < 10
                    ? const AlwaysStoppedAnimation(Colors.green)
                    : const AlwaysStoppedAnimation(Colors.red),
                borderWidth: 0,
                backgroundColor:
                    !themeProvider.isDark ? Colors.black : Colors.white,
                borderColor:
                    !themeProvider.isDark ? Colors.black : Colors.white,
                direction: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
