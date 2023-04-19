import 'package:flutter/material.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:foodboard_application/widgets/directions_bullet.dart';

import '../utils/dimensions.dart';

class DirectionsList extends StatelessWidget {
  final String step;
  final String stepCount;
  const DirectionsList({Key? key, required this.step, required this.stepCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DirectionsBullet(number: stepCount),
            SizedBox(
              width: Dimensions.Height10,
            ),
            SizedBox(
                width: Dimensions.Height200 + Dimensions.Height80,
                child: Text(
                  step,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    color: const Color(0xFF332d2b),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                )),
          ],
        ),
        SizedBox(
          height: Dimensions.Height10,
        ),
      ],
    );
  }
}
