import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_v1/data/preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/background_service.dart';
import '../utils/datetime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  final PreferencesHelper _preferencesHelper =
      PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
  Future<bool> get isScheduled async =>
      await _preferencesHelper.isDailyRestaurantActive ?? _isScheduled;

  Future<void> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    _preferencesHelper.setDailyResto(value);
    if (_isScheduled) {
      notifyListeners();
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      await AndroidAlarmManager.cancel(1);
    }
  }
}
