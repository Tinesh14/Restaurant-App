import 'package:flutter/material.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

import '../ui/detail_ui.dart';
import '../ui/home_ui.dart';

class PageRoutes {
  static String homeUi = "home_ui";
  static String detailUi = "detail_ui";

  Map<String, WidgetBuilder> routes() {
    return {
      homeUi: (context) => const HomeUi(),
      detailUi: (context) {
        return DetailUi(
          item: Restaurant(),
        );
      }
    };
  }
}
