import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'package:intl/intl.dart';
import '/imports.dart';

class LastTimeSinceList extends StatefulWidget {
  const LastTimeSinceList({super.key});

  @override
  State<LastTimeSinceList> createState() => _LastTimeSinceListState();
}

class _LastTimeSinceListState extends State<LastTimeSinceList> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: lastTimeSinceState,
      builder: (context, child) {
        if (lastTimeSinceState.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 80,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 20),
                Text(
                  "No items yet".localize,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          itemCount: lastTimeSinceState.items.length,
          separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.white24),
          itemBuilder: (context, index) {
            final item = lastTimeSinceState.items[index];
            final days = DateTime.now().difference(item.time).inDays;
            return ListTile(
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.white54,
              ),
              title: Text(
                "$days ${"days since i".localize} ${item.title}",
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().add_jm().format(item.time),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white38),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete?".localize),
                        content: Text("Are you sure you want to delete this?".localize),
                        actions: [
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Cancel".localize),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              if (item.id != null) {
                                lastTimeSinceState.delete(item.id!);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text("Delete".localize),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
