// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/auth/data/pills_model.dart';
import 'package:health_reminder/feature/auth/ui/home/view/widget/custom_drop_down_button_widget.dart';
import 'package:health_reminder/feature/auth/ui/home/view/widget/custom_text_field_widget.dart';
import 'package:health_reminder/feature/auth/ui/home/view_model/pills_view_model.dart';
import 'package:health_reminder/notification_helper.dart';

class AddPillForm extends ConsumerStatefulWidget {
  const AddPillForm({
    super.key,
    required this.formKey,
    required this.pillNameController,
    required this.descriptionController,
    required this.howLongController,
    required this.howOftenController,
    required this.lastTimeEatController,
    required this.pillsState,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController pillNameController;
  final TextEditingController descriptionController;
  final TextEditingController howLongController;
  final TextEditingController howOftenController;
  final TextEditingController lastTimeEatController;
  final AsyncValue<List<PillsModel>> pillsState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPillFormState();
}

class _AddPillFormState extends ConsumerState<AddPillForm> {
  String? howLongSelectedValue;
  String? howOftenSelectedValue;
  List<String> howLongOptions = ["Days", "Weeks", "Months"];
  List<String> howOftenOptions = ["Days", "Hours"];
  DateTime selectedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextfieldWidget(
              title: 'Pill Name',
              controller: widget.pillNameController,
            ),
            Gap(16),
            CustomTextfieldWidget(
              title: 'Description',
              controller: widget.descriptionController,
            ),

            Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextfieldWidget(
                    title: 'for how long',
                    controller: widget.howLongController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: CustomDropDownButton(
                    selectedValue: howLongSelectedValue,
                    options: howLongOptions,
                    onChanged: (item) {
                      setState(() {
                        howLongSelectedValue = item;
                      });
                    },
                  ),
                ),
              ],
            ),
            Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextfieldWidget(
                    title: 'How often should you take your pill (e.g., every 8',
                    controller: widget.howOftenController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: CustomDropDownButton(
                    selectedValue: howOftenSelectedValue,
                    options: howOftenOptions,
                    onChanged: (item) {
                      setState(() {
                        howOftenSelectedValue = item;
                      });
                    },
                  ),
                ),
              ],
            ),

            //TODO add datepicker too
            Gap(16),
            CustomTextfieldWidget(
              title: 'Last time you took your pill',
              controller: widget.lastTimeEatController,
              readOnly: true,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedTime),
                );
                if (picked != null) {
                  setState(() {
                    final now = DateTime.now();
                    selectedTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      picked.hour,
                      picked.minute,
                    );
                    widget.lastTimeEatController.text = picked.format(context);
                  });
                }
              },
            ),

            const Spacer(),
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4A90E2),
                  shape: BeveledRectangleBorder(),
                ),

                onPressed: () {
                  try {
                    if (!mounted) return;
                    if (widget.formKey.currentState!.validate()) {
                      final model = PillsModel(
                        pillName: widget.pillNameController.text,
                        description: widget.descriptionController.text,
                        howLong: int.parse(widget.howLongController.text),
                        howLongUnit: howLongSelectedValue!,
                        howOften: int.parse(widget.howOftenController.text),
                        howOftenUnit: howOftenSelectedValue!,
                        lastTimeEat: selectedTime,
                        isActive: 1,
                      );
                      ref.read(pillsProvider.notifier).addPill(model);
                      // final now = DateTime.now();
                      // NotificationHelper().scheduleNotification(
                      //   hour: now.hour,
                      //   minute: (now.minute + 1) % 60, // one minute later
                      // );
                      for (final time in model.reminders) {
                        print("Scheduling reminder for: $time");
                        NotificationHelper().scheduleNotification(
                          id: time.hashCode,
                          title: 'Pill Reminder',
                          body: 'Time to take ${model.pillName}',
                          hour: time.hour,
                          minute: time.minute,
                        );
                      }

                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("$e")));
                  }
                },
                child:
                    widget.pillsState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "Add",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
