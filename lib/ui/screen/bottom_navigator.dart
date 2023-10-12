import 'package:blog_app/ui/screen/home_screen.dart';
import 'package:blog_app/utils/constain/color_const.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          iconSize: 20,
          selectedFontSize: 10,
          currentIndex: _selectedIndex,
          items: [
            bottomNavItem("Home", Icons.home_outlined, Icons.home),
            bottomNavItem("Category", Icons.category_outlined, Icons.category),
            bottomNavItem("Notifications", Icons.notification_important_outlined, Icons.notifications),
            bottomNavItem("Menu", Icons.menu, Icons.menu_open),
          ],
          onTap: (value) {
            setState(() {_selectedIndex = value;});
          },
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavItem(String label, IconData icon, IconData iconActive){
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: COLOR_CONST.BLUE,
      activeIcon: Icon(iconActive)
    );
  }
}

