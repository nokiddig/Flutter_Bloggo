import 'package:blog_app/ui/screen/tab/home_tab.dart';
import 'package:blog_app/utils/constain/color_const.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  String _title = "";
  static List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    HomeTab(),
    HomeTab(),
    HomeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            CircleAvatar(
              backgroundColor: COLOR_CONST.GRAY7,
              child: IconButton(onPressed: (){},
                icon: Icon(Icons.search),
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: _widgetOptions[_selectedIndex]),
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

