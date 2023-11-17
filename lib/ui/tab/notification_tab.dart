import 'package:blog_app/model/notification.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/blog/blog_detail.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/repository/blog_repository.dart';
import 'package:blog_app/repository/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  NotificationRepository notificationViewmodel = NotificationRepository();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: notificationViewmodel.getByEmail(SaveAccount.currentEmail!), 
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<Noti> list = snapshot.data ?? [];
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    //onTap: redirectToNotification(context, list[index]),
                    title: Text(list[index].type),
                    subtitle: Text(list[index].content),
                    leading: Image.asset(STRING_CONST.IMAGE_DEFAULT),
                  );
                },
            );
          }
          else if (snapshot.hasError){
            return Text('Error while creating notification ${snapshot.error}');
          }
          else {
            return const CircularProgressIndicator();
          }
        });
  }

  redirectToNotification(BuildContext context, Noti notification) {
    Future.delayed(const Duration(milliseconds: 500));
    switch (notification.type){
      case MODEL_CONST.COLLECTION_BLOG:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: StreamBuilder(
              stream: BlogRepository()
                  .getById(notification.information),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return ABlogDetail(snapshot.data!);
                }
                else {
                  return const CircularProgressIndicator();
                }
              },),
          ),
        );
        break;
    }
  }
}
