import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/core/shared/widget/custom_app_bar.dart';
import 'package:health_reminder/feature/home/ui/view/screen/add_pill_screen.dart';
import 'package:health_reminder/feature/home/ui/view/widget/home_card_items_widget.dart';
import 'package:health_reminder/feature/home/ui/view_model/pills_view_model.dart';

// I was working on supabase database for pills to sync it with server
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pills = ref.watch(pillsProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfffeefd7),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xff4A90E2),
          shape: BeveledRectangleBorder(),
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPillScreen()),
            );
          },
        ),
      ),
      body: pills.when(
        data: (pills) {
          return ListView.separated(
            separatorBuilder: (context, index) => Gap(16),
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
          print(err.toString());
          return Center(
            child: Text(
              err.toString(),
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
