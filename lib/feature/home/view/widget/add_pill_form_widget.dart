// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:health_reminder/feature/home/view/widget/custom_drop_down_button_widget.dart';
import 'package:health_reminder/feature/home/view_model/pills_view_model.dart';
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
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              controller: widget.pillNameController,
              decoration: InputDecoration(
                labelText: "Pill Name",
                border: OutlineInputBorder(),
              ),
            ),
            Gap(16),
            TextFormField(
              controller: widget.descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            Gap(16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: widget.howLongController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "for how long",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Gap(8),
                Expanded(
                  flex: 2,
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
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: widget.howOftenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          "How often should you take your pill (e.g., every 8)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Gap(8),
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
            TextFormField(
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

              decoration: InputDecoration(
                labelText: "Last time you took your pill",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
