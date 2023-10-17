import 'package:blog_app/ui/screen/tab/category_tab.dart';
import 'package:blog_app/ui/screen/tab/home_tab.dart';
import 'package:blog_app/ui/screen/tab/notification_tab.dart';
import 'package:blog_app/utils/constain/color_const.dart';
import 'package:blog_app/utils/constain/font_const.dart';
import 'package:flutter/material.dart';

import '../screen/tab/menu_tab.dart';
import '../screen/tab/profile_tab.dart';

class BottomNavigationApp extends StatefulWidget {
  BottomNavigationApp({super.key});
  final GlobalKey<_BottomNavigationAppState> _stateKey = GlobalKey();

  @override
  State<BottomNavigationApp> createState() => _BottomNavigationAppState();

  void updateState(int index) {
    _stateKey.currentState?.updateIndexView(index);
  }
}

class _BottomNavigationAppState extends State<BottomNavigationApp> {
  int _selectedIndex = 0;
  int _selectedView = 0;
  final String _title = "Bloggo";
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const CategoryTab(),
    const NotificationTab(),
    const MenuTab(),
    const ProfileTab()
  ];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  final GlobalKey<_BottomNavigationAppState> _stateKey = GlobalKey<_BottomNavigationAppState>();
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
            child: _widgetOptions[_selectedView]),
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
              _selectedView = value;
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

  void updateIndexView(int index) {
    setState(() {
      _selectedView = index;
    });
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
