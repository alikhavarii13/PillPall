import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/pills_model.dart';

class AddPillScreen extends StatefulWidget {
  const AddPillScreen({super.key});

  @override
  State<AddPillScreen> createState() => _AddPillScreenState();
}

class _AddPillScreenState extends State<AddPillScreen> {
  String? howLongSelectedValue;
  String? howOftenSelectedValue;
  List<String> howLongOptions = ["Days", "Weeks", "Months"];
  List<String> howOftenOptions = ["Days", "Hours"];
  TimeOfDay selectedTime = TimeOfDay.now();
  final lastTimeEatController = TextEditingController();
  final pillNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final howLongController = TextEditingController();
  final quantityController = TextEditingController();
  final howOftenController = TextEditingController();
  final lastTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
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
                    decoration: InputDecoration(
                      labelText: "for how long",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Gap(8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Select"),
                        padding: EdgeInsets.only(left: 8),
                        value: howLongSelectedValue,
                        items:
                            howLongOptions.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),

                        onChanged: (item) {
                          setState(() {
                            howLongSelectedValue = item;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: "quantity",
                border: OutlineInputBorder(),
              ),
            ),
            Gap(16),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: howOftenController,
                    decoration: InputDecoration(
                      labelText: "how often should you eat? 8 hours ",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Gap(8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Select"),
                        padding: EdgeInsets.only(left: 8),
                        value: howOftenSelectedValue,
                        items:
                            howOftenOptions.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),

                        onChanged: (item) {
                          setState(() {
                            howOftenSelectedValue = item;
                          });
                        },
                      ),
                    ),
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
            Gap(16),
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                onPressed: () {
                  // var a = PillsModel(
                  //   pillName: pillNameController.text,
                  //   description: descriptionController.text,
                  //   howLong: int.parse(howLongController.text),
                  //   quantity: int.parse(quantityController.text),
                  //   howOften: int.parse(howOftenController.text),
                  //   lastTimeEat: lastTimeEatController.text,
                  // );

                  // print("a is $a");
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
