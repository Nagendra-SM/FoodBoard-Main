import 'package:flutter/material.dart';

class DirectionsBullet extends StatelessWidget {
  final String number;
  final Color backgroundColor;
  final double size;
  const DirectionsBullet({
    Key? key,
    required this.number,
    this.backgroundColor = const Color(0xFFBAF8BA),
    this.size = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size)),
        color: backgroundColor,
      ),
      child: Center(child: Text(number)),
    );
  }
}
