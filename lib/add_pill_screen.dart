import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/home/data/pills_model.dart';
import 'package:health_reminder/home/view/widget/custom_drop_down_button_widget.dart';
import 'package:health_reminder/home/view_model/pills_view_model.dart';

class AddPillScreen extends ConsumerStatefulWidget {
  const AddPillScreen({super.key, this.pillId});
  final int? pillId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPillScreenState();
}

class _AddPillScreenState extends ConsumerState<AddPillScreen> {
  String? howLongSelectedValue;
  String? howOftenSelectedValue;
  List<String> howLongOptions = ["Days", "Weeks", "Months"];
  List<String> howOftenOptions = ["Days", "Hours"];
  TimeOfDay selectedTime = TimeOfDay.now();
  final lastTimeEatController = TextEditingController();
  final pillNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final howLongController = TextEditingController();
  final howOftenController = TextEditingController();
  final lastTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pillsState = ref.watch(pillsProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Add Pill")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pillNameController,
              decoration: InputDecoration(
                labelText: "Pill Name",
                border: OutlineInputBorder(),
              ),
            ),
            Gap(16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            Gap(16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: howLongController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "for how long",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Gap(8),
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
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: howOftenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "how often should you eat? 8 hours ",
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
            Gap(16),
            TextField(
              controller: lastTimeEatController,
              readOnly: true,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null) {
                  setState(() {
                    selectedTime = picked;
                    lastTimeEatController.text = selectedTime.format(context);
                  });
                }
              },

              decoration: InputDecoration(
                labelText: "when was the last time that you ate your pill?",
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
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
                    ref
                        .read(pillsProvider.notifier)
                        .addPill(
                          PillsModel(
                            pillName: pillNameController.text,
                            description: descriptionController.text,
                            howLong: int.parse(howLongController.text),
                            howLongUnit: howLongSelectedValue!,
                            howOften: int.parse(howOftenController.text),
                            howOftenUnit: howOftenSelectedValue!,
                            lastTimeEat: selectedTime,
                          ),
                        );
                    if (!mounted) return;
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(" $e")));
                  }
                },
                child:
                    pillsState.isLoading
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
