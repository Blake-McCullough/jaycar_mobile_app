// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jaycar_mobile_app/homescreen/homescreen.dart';
import 'package:jaycar_mobile_app/settings/settings.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PersistantBar extends StatefulWidget {
  const PersistantBar({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PersistantBar createState() => _PersistantBar();
}

class _PersistantBar extends State<PersistantBar> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // ignore: prefer_final_fields
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [HomePage(), Settings()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: ("Explore"),
          activeColorPrimary: Color.fromRGBO(4, 218, 198, 1),
          inactiveColorPrimary: Color.fromRGBO(255, 255, 255, 1)),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("My Stuff"),
          activeColorPrimary: Color.fromRGBO(4, 218, 198, 1),
          inactiveColorPrimary: Color.fromRGBO(255, 255, 255, 1))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          Color.fromRGBO(55, 0, 179, 1), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
