import 'package:blog_app/services/firebase_authentication.dart';
import 'package:blog_app/ui/screen/login/signin_screen.dart';
import 'package:blog_app/ui/screen/tab/profile_tab.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:flutter/material.dart';

import '../../app/bottom_navigator_app.dart';

class MenuTab extends StatefulWidget {
  const MenuTab({Key? key});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UIConst.DIVIDER1,
        ListTile(
          leading: UIConst.ICON_DARKMODE,
          title: Text(StringConst.DARKMODE),
          onTap: (){},
          trailing: Switch(
            value: _isDark,
            onChanged: (bool value) {
              setState(() {
                _isDark = value;
              });
            },),
        ),
        UIConst.DIVIDER1,
        ListTile(
          style: ListTileStyle.drawer,
          leading: UIConst.ICON_PROFILE,
          title: Text(StringConst.PROFILE),
          onTap: (){
            Route route = MaterialPageRoute(builder: (context) => ProfileTab(),);
            Navigator.push(context, route);
          },
          trailing: Icon(Icons.navigate_next),
        ),
        UIConst.DIVIDER1,
        ListTile(
          leading: UIConst.ICON_SAVE,
          title: Text(StringConst.SAVED),
          onTap: (){},
          trailing: Icon(Icons.navigate_next),
        ),
        UIConst.DIVIDER1,
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text(StringConst.PROFILE),
          onTap: (){},
          trailing: Icon(Icons.navigate_next),
        ),
        UIConst.DIVIDER1,
        ListTile(
          leading: UIConst.ICON_LOGOUT,
          title: Text(StringConst.LOGOUT),
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => true,);
            signOut();
          },
        ),
        UIConst.DIVIDER1,

      ],
    );
  }
}
