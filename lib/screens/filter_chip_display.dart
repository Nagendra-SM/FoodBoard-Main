import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodboard_application/data/filter_chips_food.dart';
import 'package:foodboard_application/data/filter_chips_time.dart';
import 'package:foodboard_application/models/filter_chips_food.dart';
import 'package:foodboard_application/models/filter_chips_time.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:foodboard_application/widgets/filter_chip.dart';
import 'search_page.dart';
import 'package:foodboard_application/models/filter_chips_data.dart';
import 'package:foodboard_application/data/filter_chips.dart';

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  RangeValues _currentRangeValues = const RangeValues(5, 20);
  double _value = 6;
  List<FilterChipData> filterChips = FilterChips.all;
  List<FilterChipTimeData> filterChipsTime = FilterChipsTime.all;
  List<FilterChipFoodData> filterChipsFood = FilterChipsFood.all;
  List filterData = [];
  double ratingData = 0.0;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        // icon: const Icon(
        //   FontAwesomeIcons.times,
        //   color: const Color.fromARGB(255, 11, 228, 18),
        // ),
        // onPressed: () {
        //   Navigator.pop(context);
        // }),
        title: BigText(text: "Filter Searches", size: 22),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigText(
                  text: "Category Type",
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  runSpacing: 5,
                  spacing: 2,
                  children: filterChips
                      .map((filterChip) => FilterChip(
                            label: Text(filterChip.label),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            backgroundColor: filterChip.color,
                            onSelected: (isSelected) => setState(() {
                              if (isSelected) {
                                if (!filterData.contains(filterChip.label)) {
                                  filterData.add(filterChip.label);
                                }
                              } else {
                                if (filterData.contains(filterChip.label)) {
                                  filterData.removeWhere(
                                      (element) => element == filterChip.label);
                                }
                              }

                              filterChips = filterChips.map((otherChip) {
                                return filterChip == otherChip
                                    ? otherChip.copy(isSelected: isSelected)
                                    : otherChip;
                              }).toList();
                            }),
                            selected: filterChip.isSelected,
                            checkmarkColor: Colors.green[400],
                            selectedColor: filterChip.color,
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigText(text: 'Cooking Time'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: filterChipsTime
                      .map((filterChip) => FilterChip(
                            label: Text(filterChip.label),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            backgroundColor: filterChip.color,
                            onSelected: (isSelected) => setState(() {
                              if (isSelected) {
                                if (!filterData.contains(filterChip.label)) {
                                  filterData.add(filterChip.label);
                                }
                              } else {
                                if (filterData.contains(filterChip.label)) {
                                  filterData.removeWhere(
                                      (element) => element == filterChip.label);
                                }
                              }

                              filterChipsTime =
                                  filterChipsTime.map((otherChip) {
                                return filterChip == otherChip
                                    ? otherChip.copy(isSelected: isSelected)
                                    : otherChip;
                              }).toList();
                            }),
                            selected: filterChip.isSelected,
                            checkmarkColor: Colors.green[400],
                            selectedColor: filterChip.color,
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigText(
                  text: 'Food',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: filterChipsFood
                      .map((filterChip) => FilterChip(
                            label: Text(filterChip.label),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            backgroundColor: filterChip.color,
                            onSelected: (isSelected) => setState(() {
                              if (isSelected) {
                                if (!filterData.contains(filterChip.label)) {
                                  filterData.add(filterChip.label);
                                }
                              } else {
                                if (filterData.contains(filterChip.label)) {
                                  filterData.removeWhere(
                                      (element) => element == filterChip.label);
                                }
                              }

                              filterChipsFood =
                                  filterChipsFood.map((otherChip) {
                                return filterChip == otherChip
                                    ? otherChip.copy(isSelected: isSelected)
                                    : otherChip;
                              }).toList();
                            }),
                            selected: filterChip.isSelected,
                            checkmarkColor: Colors.green[400],
                            selectedColor: filterChip.color,
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(
              height: 20,
              thickness: 1.2,
              color: Color.fromARGB(255, 205, 198, 198),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      print(filterData);
                      // Respond to button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => searchPage(
                                  chipname: filterData,
                                )),
                      );
                      // filterData.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: const EdgeInsets.fromLTRB(30, 13, 30, 13)),
                    child: const Text('SEARCH',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
