import 'package:flutter/material.dart';

import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/big_text.dart';

class AppBtn extends StatelessWidget {
  String name;
  VoidCallback fun;
  AppBtn({
    Key? key,
    required this.name,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.darkOcean,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: fun,
        child: BigText(color: Colors.white, size: 16, text: name),
      ),
    );
  }
}
