import 'package:flutter/material.dart';

import '../models/filter_chips_data.dart';

class FilterChips {
  static final all = <FilterChipData>[
    const FilterChipData(
      label: 'BreakFast',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipData(
      label: 'Lunch',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipData(
      label: 'Dinner',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipData(
      label: 'Brunch',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
  ];
}
