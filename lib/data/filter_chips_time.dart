import 'package:flutter/material.dart';
import 'package:foodboard_application/models/filter_chips_time.dart';

class FilterChipsTime {
  static final all = <FilterChipTimeData>[
    const FilterChipTimeData(
      label: '10 min',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipTimeData(
      label: '< 30 min',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipTimeData(
      label: '> 30 min',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
    const FilterChipTimeData(
      label: '> 1 hr',
      isSelected: false,
      color: Color.fromARGB(255, 234, 233, 233),
    ),
  ];
}
