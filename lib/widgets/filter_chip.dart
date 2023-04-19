import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/utils/dimensions.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  const FilterChipWidget({Key? key, required this.chipName, required Null Function(dynamic isChecked, dynamic item) onSelected}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;
  List filterData = [];

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: BigText(
        text: widget.chipName,
        size: Dimensions.Height14,
        fontWeight: FontWeight.w500,
        color: _isSelected == true ? AppColors.whiteColor : AppColors.mainColor,
      ),
      labelStyle: const TextStyle(
        color: AppColors.blackColor,
      ),
      selected: _isSelected,
      padding: const EdgeInsets.all(5),
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(
          side: BorderSide(color: AppColors.lightGreyColor)),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          filterData.add(widget.chipName);
        });
      },
      selectedColor: AppColors.mainColor,
    );
  }
}
