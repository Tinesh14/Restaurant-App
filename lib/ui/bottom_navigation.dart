import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_app_v1/common/routes.dart';
import 'package:restaurant_app_v1/ui/favorite_ui.dart';
import 'package:restaurant_app_v1/ui/home_ui.dart';
import 'package:restaurant_app_v1/ui/setting_ui.dart';
import 'package:restaurant_app_v1/utils/background_service.dart';
import '../utils/notification_helper.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> _children;
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  PermissionStatus? status;
  @override
  void initState() {
    super.initState();
    _children = [
      HomeUi(),
      const FavoriteUi(),
      const SettingUi(),
    ];
    _checkPermission();
    _notificationHelper.configureSelectNotificationSubject(PageRoutes.detailUi);
  }

  void _checkPermission() async {
    status = await Permission.notification.status;
    if (!(status?.isGranted ?? true)) {
      status = await Permission.notification.request();
    }
  }

  void onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        FavoriteUi.refreshPage.call();
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: DotNavigationBar(
        marginR: const EdgeInsets.symmetric(
          horizontal: 60,
        ),
        paddingR: const EdgeInsets.only(),
        margin: const EdgeInsets.all(0),
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Colors.purple,
          ),

          /// Likes
          DotNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            selectedColor: Colors.pink,
          ),

          /// Profile
          DotNavigationBarItem(
            icon: const Icon(Icons.settings),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
