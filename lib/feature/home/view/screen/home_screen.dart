import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/home/view/screen/add_pill_screen.dart';
import 'package:health_reminder/feature/home/view/widget/home_card_items_widget.dart';
import 'package:health_reminder/feature/home/view_model/pills_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pills = ref.watch(pillsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // NotificationHelper().scheduleNotification(
          //   id: 1,
          //   title: "title",
          //   body: "body",
          //   hour: DateTime.now().hour,
          //   minute: DateTime.now().minute + 1,
          // );
          // NotificationHelper().showNotifications(
          //   id: 1,
          //   title: "test",
          //   body: "testing",
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPillScreen()),
          );
        },
      ),
      body: pills.when(
        data: (pills) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: pills.length,
            itemBuilder: (context, index) {
              final item = pills[index];
              return HomeCardItemsWidget(
                item: item,
                deleteOnPressed: (context) {
                  ref.read(pillsProvider.notifier).removePill(item.id!);
                },
                editOnPressed: (context) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPillScreen(pillId: item.id!),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (err, stack) {
          return Center(
            child: Text(
              'Something went wrong. Please try again later.',
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
