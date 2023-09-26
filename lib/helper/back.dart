import 'package:flutter/material.dart';

class back extends StatelessWidget {
  const back({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: width * 0.2,
        child: Row(
          children: [
            Image.asset(
              'assets/icons/left.png',
              width: width * 0.08,
            ),
            Text('Home')
          ],
        ),
      ),
    );
  }
}
