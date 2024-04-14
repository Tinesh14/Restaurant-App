import 'package:flutter/material.dart';
import 'package:restaurant_app_v1/ui/bottom_navigation.dart';
import 'package:restaurant_app_v1/ui/favorite_ui.dart';
import 'package:restaurant_app_v1/ui/setting_ui.dart';

import '../ui/detail_ui.dart';
import '../ui/home_ui.dart';

class PageRoutes {
  static String homeUi = "home_ui";
  static String detailUi = "detail_ui";
  static String bottomNavigation = "bottom_navigation";
  static String favoriteUi = "favorite_ui";
  static String settingUi = "setting_ui";

  Map<String, WidgetBuilder> routes() {
    return {
      homeUi: (context) => const HomeUi(),
      detailUi: (context) {
        Map<String, dynamic> argument =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        return DetailUi(
          id: argument['id'],
          itemRestaurant: argument['data'],
        );
      },
      bottomNavigation: (context) => const BottomNavigation(),
      favoriteUi: (context) => const FavoriteUi(),
      settingUi: (context) => const SettingUi(),
    };
  }
}
