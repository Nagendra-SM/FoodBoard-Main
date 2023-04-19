import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_application/models/hotels_model.dart';
import 'package:foodboard_application/screens/favorite_Screen.dart';
import 'package:foodboard_application/screens/home_page.dart';
import 'package:foodboard_application/screens/recipe_details.dart';

import 'package:foodboard_application/widgets/hotels_card.dart';

import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/app_column.dart';
import 'package:foodboard_application/widgets/app_icon.dart';
import 'package:foodboard_application/widgets/big_text.dart';

import 'package:foodboard_application/widgets/directions_list.dart';

import 'package:foodboard_application/widgets/ingredient_list.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RecipeFavorite extends StatefulWidget {
  const RecipeFavorite({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Map<String, dynamic> model;

  @override
  State<RecipeFavorite> createState() => _RecipeFavoriteState();
}

class _RecipeFavoriteState extends State<RecipeFavorite> {
  bool flag = true;
  bool directionFlag = true;
  bool hotelFlag = true;
  Color _iconColor = Color.fromARGB(255, 239, 7, 7);

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Hotels>> getHotelsData() async {
    var data = await http.get(Uri.parse(
        "https://run.mocky.io/v3/87caf299-bd4a-45a8-8497-b16dee15cdb3"));
    var jsonData = jsonDecode(data.body);
    List<Hotels> hotelsData = [];
    for (var h in jsonData) {
      Hotels hotels = Hotels(
        NAME: h["NAME"],
        PRICE: h["PRICE"],
        CUSINE_CATEGORY: h["CUSINE_CATEGORY"],
        CITY: h["CITY"],
        REGION: h["REGION"],
        LOGOURL: h["logo_url"],
        TIMING: h["TIMING"],
        RATING: h["RATING"],
        URL: h["URL"],
      );

      hotelsData.add(hotels);
    }
    print(hotelsData.length);

    return hotelsData;
  }

  int count = 4;
  int hotelCount = 2;
  int stepCount = 4;

  @override
  void initState() {
    super.initState();
    // getHotelsData();
    // _handleLocationPermission();
    // _getCurrentPosition();
  }

  String? _currentAddress;
  Position? _currentPosition;

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getCityName(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  // Future<void> _getCityName(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //           "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('ADDRESS: ${_currentAddress ?? ""}');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            title: InkWell(
              onTap: () async {
                final User? user = auth.currentUser;
                final uid = user?.uid;

                final removeDataindb = FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('favoriteList')
                    .doc(widget.model['recipeID'])
                    .delete()
                    .then((_) {
                  print('Deleted Successfully');
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeDetails()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //const AppIcon(icon: Icons.arrow_back_ios),
                  AppIcon(
                    icon: Icons.favorite,
                    iconSize: 20,
                    iconColor: Color.fromARGB(255, 239, 7, 7),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(42, 2.0, 20, 0),
                  child: BigText(
                    size: 22,
                    text: "${widget.model['recipeName']}",
                    maxLines: 2,
                  ),
                )),
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 12, bottom: 10),
                decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
              ),
            ),
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.iconColor,
            flexibleSpace: FlexibleSpaceBar(
                background: Image(
              image: NetworkImage("${widget.model['recipeImage']}".toString()),
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration:
                      const BoxDecoration(color: AppColors.backgroundColor),
                  child: Column(
                    children: [
                      AppColumn(
                          // prepTime: widget.model.totalTime.toString(),
                          ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: "Ingredients",
                                  color: AppColors.textColor,
                                ),
                                BigText(
                                  text: widget.model['ingredientList'].length
                                          .toString() +
                                      " Items",
                                  color: AppColors.lightGreyColor,
                                  size: 18,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            for (int i = 0; i < count; i++)
                              IngredientList(
                                imageUrl: widget.model['ingredientList']
                                    [i.toString()]['ingredientUrl'],
                                ingredientName: widget.model['ingredientList']
                                    [i.toString()]['ingredientName'],
                                ingredientCount: widget.model['ingredientList']
                                    [i.toString()]['ingredientCount'],
                              ),
                            InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    flag ? "show more" : "show less",
                                    style: const TextStyle(
                                        color: AppColors.mainColor),
                                  ),
                                  Icon(
                                    flag
                                        ? Icons.arrow_drop_down
                                        : Icons.arrow_drop_up,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  flag = !flag;
                                  count = flag
                                      ? 4
                                      : widget.model['ingredientList'].length;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                BigText(
                                  text: "Directions",
                                  color: AppColors.textColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                for (int i = 0; i < stepCount; i++)
                                  DirectionsList(
                                      step: widget.model['directionList']
                                          [i.toString()],
                                      stepCount: (i + 1).toString())
                              ],
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    directionFlag ? "show more" : "show less",
                                    style: const TextStyle(
                                        color: AppColors.mainColor),
                                  ),
                                  Icon(
                                    directionFlag
                                        ? Icons.arrow_drop_down
                                        : Icons.arrow_drop_up,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  directionFlag = !directionFlag;
                                  stepCount = directionFlag
                                      ? 4
                                      : widget.model['directionList'].length;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                BigText(
                                  text: "Hotel Near By Location",
                                  color: AppColors.textColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HotelCard(
                              hotelList: getHotelsData(),
                            ),
                            // InkWell(
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         hotelFlag ? "show more" : "show less",
                            //         style: const TextStyle(
                            //             color: AppColors.mainColor),
                            //       ),
                            //       Icon(
                            //         hotelFlag
                            //             ? Icons.arrow_drop_down
                            //             : Icons.arrow_drop_up,
                            //         color: AppColors.mainColor,
                            //       ),
                            //     ],
                            //   ),
                            //   // onTap: () {
                            //   //   setState(() {
                            //   //     hotelFlag = !hotelFlag;
                            //   //     hotelCount = hotelFlag
                            //   //         ? 2
                            //   //         : widget.model.hotels!.length;
                            //   //   });
                            //   // },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Place {
  final String name;
  final String vicinity;
  final double latitude;
  final double longitude;
  final String photoReference;
  final num rating;

  Place({
    required this.name,
    required this.vicinity,
    required this.latitude,
    required this.longitude,
    required this.photoReference,
    required this.rating,
  });
}
