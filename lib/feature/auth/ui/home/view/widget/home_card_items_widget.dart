import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/auth/data/pills_model.dart';
import 'package:health_reminder/feature/auth/ui/home/view/widget/rich_text_info_widget.dart';

class HomeCardItemsWidget extends StatelessWidget {
  const HomeCardItemsWidget({
    super.key,
    required this.item,
    required this.deleteOnPressed,
    required this.editOnPressed,
  });

  final PillsModel item;
  final void Function(BuildContext)? deleteOnPressed;
  final void Function(BuildContext)? editOnPressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Confirmation"),
                    content: const Text(
                      'Are you sure you want to delete this item? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          if (deleteOnPressed != null) {
                            deleteOnPressed!(context);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: editOnPressed,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
        ),
        child: SizedBox(
          width: double.infinity,
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
                RichTextInfoWidget(label: "Count", info: item.count.toString()),
                Gap(8),
                RichTextInfoWidget(
                  label: "Every",
                  info: item.howOften.toString(),
                  period: item.howOftenUnit,
                ),
                Gap(8),
                RichTextInfoWidget(
                  label: "Last Taken",
                  info: item.lastTimeEat.toString(),
                  // DateFormat(
                  //   "EEE, MMM d 'yy • hh:mm a",
                  // ).format(item.lastTimeEat),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
