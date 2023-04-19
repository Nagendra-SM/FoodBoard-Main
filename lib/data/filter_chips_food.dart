import 'package:flutter/material.dart';
import 'package:foodboard_application/models/filter_chips_food.dart';

import '../models/filter_chips_data.dart';

class FilterChipsFood {
  static final all = <FilterChipFoodData>[
    FilterChipFoodData(
      label: 'Cake',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Salad',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Pasta',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Desert',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Main Course',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Appetizer',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Soup',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Non-Veg',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    FilterChipFoodData(
      label: 'Veg',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
  ];
}
