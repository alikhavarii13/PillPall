import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/pills_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pills = ref.watch(pillsProvider);
    return Scaffold(
      body: pills.when(
        data: (pills) {
          return ListView.builder(
            itemCount: pills.length,
            itemBuilder: (context, index) {
              return Text(pills[index].pillName);
            },
          );
        },
        error: (err, stack) {
          return Text(err.toString());
        },
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
