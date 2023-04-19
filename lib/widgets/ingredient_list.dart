import 'package:flutter/material.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/utils/dimensions.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:foodboard_application/widgets/ingredient_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

class IngredientList extends StatelessWidget {
  final String imageUrl;
  final String ingredientName;
  final String ingredientCount;
  const IngredientList(
      {Key? key,
      required this.ingredientName,
      required this.imageUrl,
      required this.ingredientCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DirectionsBullet(number: stepCount),
            IngredientImage(imageUrl: imageUrl),
            SizedBox(
              width: Dimensions.Width10,
            ),
            Row(
              children: [
                Container(
                  width: Dimensions.Width100,
                  child: BigText(
                    text: ingredientName,
                    color: AppColors.textColor,
                    size: Dimensions.Height18,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              ingredientCount,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 146, 141, 141),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.Height10,
        ),
      ],
    );
  }
}
