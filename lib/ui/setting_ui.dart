import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';

class SettingUi extends StatefulWidget {
  const SettingUi({super.key});

  @override
  State<SettingUi> createState() => _SettingUiState();
}

class _SettingUiState extends State<SettingUi> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Setting",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  Material(
                    child: ListTile(
                      title: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Restaurant Notification'),
                          Text(
                            'Enable Notification',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return FutureBuilder(
                            future: scheduled.isScheduled,
                            builder: (context, snapshot) {
                              return Switch.adaptive(
                                value: snapshot.data ?? false,
                                onChanged: (value) async {
                                  if (Platform.isIOS) {
                                    customDialog(context);
                                  } else {
                                    scheduled.scheduledRestaurant(value);
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
