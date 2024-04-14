import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant_app_v1/main.dart';
import 'package:restaurant_app_v1/utils/notification_helper.dart';
import '../data/api/api_service.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getListRestaurant();
    var data = result.restaurants?.toList() ?? [];
    var randomIndex = Random().nextInt(data.length);
    var randomData = data[randomIndex];
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, randomData);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
