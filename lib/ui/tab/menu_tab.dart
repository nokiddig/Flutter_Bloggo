import 'package:blog_app/services/firebase_authentication.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/profile/edit_profile.dart';
import 'package:blog_app/ui/screen/login/signin_screen.dart';
import 'package:blog_app/ui/screen/profile/profile_tab.dart';
import 'package:blog_app/ui/screen/blog/save_tab.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:flutter/material.dart';

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
        UI_CONST.DIVIDER1,
        ListTile(
          leading: UI_CONST.ICON_DARKMODE,
          title: Text(STRING_CONST.DARKMODE),
          onTap: (){},
          trailing: Switch(
            value: _isDark,
            onChanged: (bool value) {
              setState(() {
                _isDark = value;
              });
            },),
        ),
        UI_CONST.DIVIDER1,
        ListTile(
          style: ListTileStyle.drawer,
          leading: UI_CONST.ICON_PROFILE,
          title: Text(STRING_CONST.PROFILE),
          onTap: (){
            Route route = MaterialPageRoute(builder: (context) => ProfileTab(email: SaveAccount.currentEmail?? "email"),);
            Navigator.push(context, route);
          },
          trailing: Icon(Icons.navigate_next),
        ),
        UI_CONST.DIVIDER1,
        ListTile(
          style: ListTileStyle.drawer,
          leading: Icon(Icons.manage_accounts_outlined),
          title: Text(STRING_CONST.EDIT_PROFILE),
          onTap: (){
            Route route = MaterialPageRoute(builder: (context) => EditProfile());
            Navigator.push(context, route);
          },
          trailing: Icon(Icons.navigate_next),
        ),
        UI_CONST.DIVIDER1,
        ListTile(
          leading: UI_CONST.ICON_SAVE,
          title: Text(STRING_CONST.SAVED),
          onTap: (){
            Route route = MaterialPageRoute(builder: (context) => SaveTab(),);
            Navigator.push(context, route);
          },
          trailing: Icon(Icons.navigate_next),
        ),
        UI_CONST.DIVIDER1,
        ListTile(
          leading: UI_CONST.ICON_LOGOUT,
          title: Text(STRING_CONST.LOGOUT),
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => true,);
            signOut();
          },
        ),
        UI_CONST.DIVIDER1,
      ],
    );
  }
}
