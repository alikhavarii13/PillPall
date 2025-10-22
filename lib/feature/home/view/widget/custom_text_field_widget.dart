import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextfieldWidget extends StatelessWidget {
  const CustomTextfieldWidget({
    super.key,

    required this.title,
    required this.controller,
    this.keyboardType,
    this.onTap,
    this.readOnly,
  });

  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Gap(8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
          ),
          child: TextFormField(
            onTap: onTap,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(contentPadding: EdgeInsets.all(8.0)),
          ),
        ),
      ],
    );
  }
}
