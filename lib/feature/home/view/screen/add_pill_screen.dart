import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/home/data/pills_model.dart';
import 'package:health_reminder/feature/home/view/widget/custom_drop_down_button_widget.dart';
import 'package:health_reminder/feature/home/view_model/pills_view_model.dart';
import 'package:health_reminder/notification_helper.dart';

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
  DateTime selectedTime = DateTime.now();
  final lastTimeEatController = TextEditingController();
  final pillNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final howLongController = TextEditingController();
  final howOftenController = TextEditingController();
  final lastTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    lastTimeEatController.dispose();
    pillNameController.dispose();
    descriptionController.dispose();
    howLongController.dispose();
    howOftenController.dispose();
    lastTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pillsState = ref.watch(pillsProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Add Pill")),
      body: Form(
        key: formKey,
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
                controller: pillNameController,
                decoration: InputDecoration(
                  labelText: "Pill Name",
                  border: OutlineInputBorder(),
                ),
              ),
              Gap(16),
              TextFormField(
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
                    child: TextFormField(
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
                    child: TextFormField(
                      controller: howOftenController,
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
                controller: lastTimeEatController,
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
                      lastTimeEatController.text = picked.format(context);
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
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
                      if (formKey.currentState!.validate()) {
                        final model = PillsModel(
                          pillName: pillNameController.text,
                          description: descriptionController.text,
                          howLong: int.parse(howLongController.text),
                          howLongUnit: howLongSelectedValue!,
                          howOften: int.parse(howOftenController.text),
                          howOftenUnit: howOftenSelectedValue!,
                          lastTimeEat: selectedTime,
                          isActive: 1,
                        );
                        ref.read(pillsProvider.notifier).addPill(model);

                        NotificationHelper().scheduleNotification(
                          hour: model.reminder.hour,
                          minute: model.reminder.minute,
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("$e")));
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
      ),
    );
  }
}
