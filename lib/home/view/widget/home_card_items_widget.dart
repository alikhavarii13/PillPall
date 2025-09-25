import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/home/data/pills_model.dart';
import 'package:health_reminder/home/view/widget/rich_text_info_widget.dart';

class HomeCardItemsWidget extends StatelessWidget {
  const HomeCardItemsWidget({
    super.key,
    required this.item,
    required this.onPressed,
  });

  final PillsModel item;
  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onPressed,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.pillName, style: TextStyle(fontSize: 22)),
                Gap(16),
                RichTextInfoWidget(
                  label: "For",
                  info: item.howLong.toString(),
                  period: "Weeks",
                ),
                Gap(8),
                RichTextInfoWidget(
                  label: "Every",
                  info: item.howOften.toString(),
                  period: "Hours",
                ),
                Gap(8),
                RichTextInfoWidget(
                  label: "Last Taken",
                  info: item.lastTimeEat.format(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
