import 'package:flutter/material.dart';
import 'package:foodboard_application/models/recipe.dart';
import 'package:foodboard_application/utils/dimensions.dart';

import '../utils/app_style.dart';

class FoodCard extends StatelessWidget {
  FoodCard(this.model, {Key? key}) : super(key: key);
  Recipe model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.Height200 + Dimensions.Height60,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              image: NetworkImage(model.images), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.Height100 + Dimensions.Height10,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  style: AppStyle.mainTitleStyle,
                ),
                Text(
                  model.rating!.toString(),
                  style: AppStyle.subTitleStyle,
                ),
                SizedBox(height: Dimensions.Height18 - Dimensions.Height10),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      model.discription!,
                      style: TextStyle(
                          color: Colors.amber, fontSize: Dimensions.Height16),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.timer,
                      color: Colors.blueGrey.shade200,
                    ),
                    Text(
                      model.totalTime!,
                      style: TextStyle(
                          color: Colors.blueGrey.shade200,
                          fontSize: Dimensions.Height16),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
