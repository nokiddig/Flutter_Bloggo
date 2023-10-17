import 'package:blog_app/ui/screen/tab/category_tab.dart';
import 'package:blog_app/ui/screen/tab/home_tab.dart';
import 'package:blog_app/ui/screen/tab/notification_tab.dart';
import 'package:blog_app/utils/constain/color_const.dart';
import 'package:blog_app/utils/constain/font_const.dart';
import 'package:flutter/material.dart';

import '../screen/tab/menu_tab.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  String _title = "Bloggo";
  static List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    CategoryTab(),
    NotificationTab(),
    MenuTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title, style: FONT_CONST.FONT_APP,),
          actions: [
            CircleAvatar(
              backgroundColor: COLOR_CONST.GRAY7,
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearch(),
                  );
                },
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
            bottomNavItem("Notifications",
                Icons.notification_important_outlined, Icons.notifications),
            bottomNavItem("Menu", Icons.menu, Icons.menu_open),
          ],
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavItem(
      String label, IconData icon, IconData iconActive) {
    return BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
        backgroundColor: COLOR_CONST.BLUE,
        activeIcon: Icon(iconActive));
  }
}

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      this.query = '';
    }, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("data");
  }
}
