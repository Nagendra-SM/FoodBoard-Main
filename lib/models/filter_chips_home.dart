import 'package:flutter/material.dart';

class FilterChipsHomeData {
  final String label;
  final Color color;
  final bool isSelected;

  const FilterChipsHomeData({
    required this.label,
    required this.color,
    this.isSelected = false,
  });

  FilterChipsHomeData copy({
    String? label,
    Color? color,
    bool? isSelected,
  }) =>
      FilterChipsHomeData(
        label: label ?? this.label,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipsHomeData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          color == other.color &&
          isSelected == other.isSelected;

  @override
  int get hashCode => label.hashCode ^ color.hashCode ^ isSelected.hashCode;
}
