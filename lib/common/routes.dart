import 'package:flutter/material.dart';

import '../data/model/restaurant.dart';
import '../ui/detail_ui.dart';
import '../ui/home_ui.dart';


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
