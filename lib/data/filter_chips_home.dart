import 'package:flutter/material.dart';
import 'package:foodboard_application/models/filter_chips_home.dart';

class FilterChipsHome {
  static final all = <FilterChipsHomeData>[
    const FilterChipsHomeData(
      label: 'Lunch',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipsHomeData(
      label: 'BreakFast',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipsHomeData(
      label: 'Brunch',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipsHomeData(
      label: 'Dinner',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
  ];
}
