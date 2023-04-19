import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String? title;
  final String? rating;
  final String? cookTime;
  final String? thumbnailUrl;
  TextEditingController firstname = TextEditingController();
  //FocusNode first = FocusNode();
  RecipeCard({
    required this.title,
    required this.cookTime,
    required this.rating,
    required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0.0, 20, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: size.width / 3.7,
                      width: size.width / 3.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(thumbnailUrl!)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: size.width / 20,
                    ),
                    SizedBox(
                      height: size.width / 3.7,
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            title!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          // const Text(
                          //   "Chinese - Sushi - Chinese Food",
                          //   style: TextStyle(fontSize: 12),
                          // ),
                          Row(
                            children: [
                              Container(
                                height: size.width / 17,
                                width: size.width / 6,
                                decoration: BoxDecoration(
                                  //color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.amber, width: 1.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[700],
                                      size: size.width / 24,
                                    ),
                                    Text(
                                      rating!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow[700],
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width / 29,
                              ),
                              Container(
                                height: size.width / 17,
                                width: size.width / 4.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.amber, width: 1.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.copyright_sharp,
                                      color: Colors.yellow[700],
                                      size: size.width / 24,
                                    ),
                                    Text(
                                      cookTime!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow[700],
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ]),
    );
  }
}
