import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/home/ui/view/screen/add_pill_screen.dart';
import 'package:health_reminder/feature/home/ui/view/widget/home_card_items_widget.dart';
import 'package:health_reminder/feature/home/ui/view_model/pills_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pills = ref.watch(pillsProvider);
    return Scaffold(
      //  appBar:
      // AppBar(
      //   title: Text("Home", style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.black,
      // ),
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
      body: Column(
        children: [
          Container(
            height: 56,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: BoxDecoration(
              color: Color(0xfffeefd7),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
            ),
            child: Center(
              child: Text(
                "Home",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
          pills.when(
            data: (pills) {
              return ListView.separated(
                shrinkWrap: true,
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
        ],
      ),
    );
  }
}
