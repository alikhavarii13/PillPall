import 'package:flutter/material.dart';

class RichTextInfoWidget extends StatelessWidget {
  const RichTextInfoWidget({
    required this.label,
    required this.info,
    this.period,
    super.key,
  });
  final String info;
  final String label;
  final String? period;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          TextSpan(
            text: '$info ${period ?? ''}',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
