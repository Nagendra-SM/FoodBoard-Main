// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodboard_application/models/hotels_model.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/utils/dimensions.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:foodboard_application/widgets/small_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelCard extends StatefulWidget {
  final Future<List<Hotels>> hotelList;

  const HotelCard({
    Key? key,
    required this.hotelList,
  }) : super(key: key);

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool flag = true;
  bool hotelFlag = true;
  int hotelCount = 2;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.hotelList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    final uri = Uri.parse(snapshot.data[index].URL);

                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(4, 0, 7, 10),
                    padding: const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.lightGreyColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Dimensions.Height90 - Dimensions.Height15,
                          height: Dimensions.Height90 - Dimensions.Height15,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/restaurant.png')),
                            borderRadius:
                                BorderRadius.circular(Dimensions.Height15),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: Dimensions.Width200,
                                child:
                                    BigText(text: snapshot.data[index].NAME)),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: Dimensions.Width200,
                                child: SmallText(
                                  text: snapshot.data[index].CUSINE_CATEGORY,
                                  size: Dimensions.Height16,
                                  color: AppColors.smallTextColor,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text:
                                      "\u{20B9}${snapshot.data[index].PRICE} for Two",
                                  size: 18,
                                ),
                                SizedBox(
                                  width: Dimensions.Width30,
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        BigText(
                                          text: snapshot.data[index].RATING,
                                          size: Dimensions.Height16,
                                          color: AppColors.whiteColor,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: AppColors.whiteColor,
                                          size: Dimensions.Height16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
