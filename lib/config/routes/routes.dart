import 'package:flutter/material.dart';
import 'package:restaurant_app_v1/model/restaurant.dart';
import 'package:restaurant_app_v1/pages/detail_ui.dart';
import 'package:restaurant_app_v1/pages/home_ui.dart';

class PageRoutes {
  static String homeUi = "home_ui";
  static String detailUi = "detail_ui";

  Map<String, WidgetBuilder> routes() {
    return {
      homeUi: (context) => const HomeUi(),
      detailUi: (context) {
        Restaurant? argument =
            ModalRoute.of(context)?.settings.arguments as Restaurant?;
        return DetailUi(
          item: argument ?? Restaurant(),
        );
      }
    };
  }
}
