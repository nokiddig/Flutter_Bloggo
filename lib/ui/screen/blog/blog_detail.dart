import 'package:blog_app/model/account.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/blog/edit_blog.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:blog_app/viewmodel/save_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/save.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({super.key, required this.blog});
  final Blog blog;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
        ),
        body: ABlogDetail(widget.blog));
  }
}

class ABlogDetail extends StatelessWidget {
  Blog blog;
  BlogViewmodel blogViewmodel = BlogViewmodel();
  ABlogDetail(this.blog, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "blog-detail-${blog.id}",
      child: SingleChildScrollView(
        child: Column(
          children: [
            UI_CONST.SIZEDBOX10,
            FutureBuilder(
              future: AccountViewModel().getByEmail(blog.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String? avatar = snapshot.data?.avatarPath;
                  String? name = snapshot.data?.name;
                  String? email = snapshot.data?.email;
                  return SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                avatar ?? "",
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  STRING_CONST.IMAGE_DEFAULT,
                                ),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name ?? "name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FONT_CONST.BESTIE.fontFamily
                                )
                              ),
                              Text(email ?? "email"),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            List<PopupMenuEntry> list = [const PopupMenuItem(child: Text("Save"),
                                value: STRING_CONST.VALUE_SAVE)];
                            if (SaveAccount.currentEmail == email){
                              list.addAll([
                                const PopupMenuItem(child: Text("Edit"),
                                  value: STRING_CONST.VALUE_EDIT,
                                ),
                                const PopupMenuItem(child: Text("Delete"),
                                  value: STRING_CONST.VALUE_DELETE,
                                ),]);
                            }
                            return list;
                          },
                          onSelected: (value) {
                            switch (value) {
                              case STRING_CONST.VALUE_DELETE:
                                this.deleteBlog(context);                                break;
                              case STRING_CONST.VALUE_EDIT:
                                this.editBlog(context); 
                                break;
                              case STRING_CONST.VALUE_SAVE:
                                this.saveBlog();
                                break;
                            }
                          },
                        )
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10 ,left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor)
                    ),
                    child: Image.network(blog.image)
                  ),
                  Text(blog.title, style: FONT_CONST.TITLE_BLOG),
                  Text(blog.content, style: FONT_CONST.CONTENT_BLOG,),
                  UI_CONST.SIZEDBOX10,
                  UI_CONST.DIVIDER1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                      VerticalDivider(color: Colors.black,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined)),
                    ],
                  ),
                  UI_CONST.DIVIDER1,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteBlog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('You want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                blogViewmodel.delete(blog.id);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void editBlog(BuildContext context) {
    Route route = MaterialPageRoute(builder: (context) => EditBlog(blog),);
    Navigator.push(context, route);
  }

  void saveBlog() {
    Timestamp time = Timestamp.fromDate(DateTime.now());
    if (SaveAccount.currentEmail != null)
      SaveViewmodel().add(Save(SaveAccount.currentEmail! ,blog.id, time));
  }
}
