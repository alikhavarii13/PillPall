import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/home/view/widget/add_pill_form_widget.dart';
import 'package:health_reminder/feature/home/view_model/pills_view_model.dart';

class AddPillScreen extends ConsumerStatefulWidget {
  const AddPillScreen({super.key, this.pillId});
  final int? pillId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPillScreenState();
}

class _AddPillScreenState extends ConsumerState<AddPillScreen> {
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
      body: AddPillForm(
        formKey: formKey,
        pillNameController: pillNameController,
        descriptionController: descriptionController,
        howLongController: howLongController,
        howOftenController: howOftenController,
        lastTimeEatController: lastTimeEatController,
        pillsState: pillsState,
      ),
    );
  }
}
