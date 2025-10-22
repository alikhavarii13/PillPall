import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  final String? selectedValue;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text("Select"),
          padding: EdgeInsets.only(left: 8),
          value: selectedValue,
          items:
              options.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
