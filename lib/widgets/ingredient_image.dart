import 'package:flutter/material.dart';
import 'package:foodboard_application/utils/colors.dart';

class IngredientImage extends StatelessWidget {
  final String imageUrl;
  final Color backgroundColor;
  final double size;
  const IngredientImage({
    Key? key,
    required this.imageUrl,
    this.backgroundColor = Colors.white,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size + 1,
      backgroundColor: AppColors.lightGreyColor,
      child: CircleAvatar(
        radius: size,
        backgroundColor: backgroundColor,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
