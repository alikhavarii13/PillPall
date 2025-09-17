import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/pills_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pills = ref.watch(pillsProvider);
    return Scaffold(
      body: pills.when(
        data: (pills) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: pills.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pills[index].pillName,
                        style: TextStyle(fontSize: 22),
                      ),
                      Gap(16),
                      RichTextInfoWidget(
                        label: "For",
                        info: pills[index].howLong.toString(),
                        period: "Weeks",
                      ),
                      Gap(8),
                      RichTextInfoWidget(
                        label: "Every",
                        info: pills[index].howOften.toString(),
                        period: "Hours",
                      ),
                      Gap(8),
                      RichTextInfoWidget(
                        label: "Last Taken",
                        info: pills[index].lastTimeEat.format(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (err, stack) {
          return Text(err.toString());
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

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
          TextSpan(text: "$label: ", style: TextStyle(fontSize: 16)),
          TextSpan(
            text: '$info ${period ?? ''}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
