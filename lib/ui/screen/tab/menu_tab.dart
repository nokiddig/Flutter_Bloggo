import 'package:blog_app/services/firebase_authentication.dart';
import 'package:blog_app/ui/screen/login/signin_screen.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:flutter/material.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(),
        ListTile(
          style: ListTileStyle.drawer,
          leading: UIConst.ICON_PROFILE,
          title: Text("Profile"),
          onTap: (){},
        ),
        Divider(),
        ListTile(
          leading: UIConst.ICON_SAVE,
          title: Text("Saved"),
          onTap: (){},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text("Profile"),
          onTap: (){},
        ),
        Divider(),
        ListTile(
          leading: UIConst.ICON_LOGOUT,
          title: Text("Logout"),
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => true,);
            signOut();
          },
        ),
        Divider(),
      ],
    );
  }
}
