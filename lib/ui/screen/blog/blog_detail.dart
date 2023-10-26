// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:blog_app/model/account.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/model/comment.dart';
import 'package:blog_app/model/like.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/blog/edit_blog.dart';
import 'package:blog_app/ui/screen/item/avatar.dart';
import 'package:blog_app/ui/screen/profile/profile_tab.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:blog_app/viewmodel/comment_viewmodel.dart';
import 'package:blog_app/viewmodel/like_viewmodel.dart';
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
        body: Hero(
            tag: "blog-detail-${widget.blog.id}",
            child: ABlogDetail(widget.blog)));
  }
}

class ABlogDetail extends StatefulWidget {
  Blog blog;

  ABlogDetail(this.blog, {super.key});

  @override
  State<ABlogDetail> createState() => _ABlogDetailState();
}

class _ABlogDetailState extends State<ABlogDetail> {
  BlogViewmodel blogViewmodel = BlogViewmodel();
  LikeViewmodel likeViewmodel = LikeViewmodel();
  CommentViewmodel commentViewmodel = CommentViewmodel();
  AccountViewModel accountViewModel = AccountViewModel();
  final TextEditingController _commentController = TextEditingController();
  bool _isCommentVisible = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UI_CONST.SIZEDBOX10,
          FutureBuilder(
            future: AccountViewModel().getByEmail(widget.blog.email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Account account =
                    snapshot.data ?? Account("", "", "", true, 0);
                return SingleChildScrollView(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                            builder: (context) =>
                                ProfileTab(email: account.email),
                          );
                          Navigator.push(context, route);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: createBloggerAvatar(account, context)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(account.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FONT_CONST.BESTIE.fontFamily)),
                            Text(account.email),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) {
                          List<PopupMenuEntry> list = [
                            const PopupMenuItem(
                                value: STRING_CONST.VALUE_SAVE,
                                child: Text("Save"))
                          ];
                          if (SaveAccount.currentEmail == account.email) {
                            list.addAll([
                              const PopupMenuItem(
                                value: STRING_CONST.VALUE_EDIT,
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: STRING_CONST.VALUE_DELETE,
                                child: Text("Delete"),
                              ),
                            ]);
                          }
                          return list;
                        },
                        onSelected: (value) {
                          switch (value) {
                            case STRING_CONST.VALUE_DELETE:
                              deleteBlog(context);
                              break;
                            case STRING_CONST.VALUE_EDIT:
                              editBlog(context);
                              break;
                            case STRING_CONST.VALUE_SAVE:
                              saveBlog();
                              break;
                          }
                        },
                      )
                    ],
                  ),
                );
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
          StreamBuilder<Blog?>(
              stream: blogViewmodel.getById(widget.blog.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Blog blogSnap = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor)),
                            child: Image.network(blogSnap.image)),
                        Text(blogSnap.title, style: FONT_CONST.TITLE_BLOG),
                        Text(
                          blogSnap.content,
                          style: FONT_CONST.CONTENT_BLOG,
                        ),
                        UI_CONST.SIZEDBOX10,
                        UI_CONST.DIVIDER2,
                        buildReaction(),
                        UI_CONST.DIVIDER2,
                        if (_isCommentVisible) buildComment(),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }

  Widget buildComment() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  left: UI_CONST.BORDER_SIDE,
                  right: UI_CONST.BORDER_SIDE,
                  bottom: UI_CONST.BORDER_SIDE
              )),
          constraints: BoxConstraints(maxHeight: 100, minHeight: 0),
          child: StreamBuilder(
            stream: commentViewmodel.getByBlogId(widget.blog.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Comment> list = snapshot.data ?? [];
                if (list.isEmpty) {
                  return const Text("First comment");
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => FutureBuilder(
                      future: accountViewModel.getByEmail(list[index].email),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Account cmtAccount = snapshot.data!;
                          return ListTile(
                            leading: createBloggerAvatar(cmtAccount, context),
                            title: Text(
                              cmtAccount.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(list[index].content),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                );
              } else if (snapshot.hasError) {
                return Text("Read comment Error: ${snapshot.error}");
              } else
                return const Text("First comment");
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
              width: 230,
              child: Card(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Type your comment...',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                  controller: _commentController,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  submitComment();
                },
                child: Text('Submit'))
          ],
        ),
        UI_CONST.SIZEDBOX20
      ],
    );
  }

  Future<void> submitComment() async {
    String content = _commentController.text;
    Comment comment = Comment("", content, SaveAccount.currentEmail!,
        Timestamp.fromDate(DateTime.now()), widget.blog.id);
    await commentViewmodel.add(comment);
    _commentController.text = "";
  }

  Widget buildReaction() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buildLikeCount(), VerticalDivider(), buildCommentCount()],
      ),
    );
  }

  Widget buildLikeCount() {
    return Center(
      child: Row(
        children: [
          StreamBuilder(
              stream: likeViewmodel.checkLike(
                  SaveAccount.currentEmail!, widget.blog.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool isLike = snapshot.data ?? false;
                  IconData icon =
                      isLike == true ? Icons.favorite : Icons.favorite_border;
                  return IconButton(
                    onPressed: () {
                      if (isLike) {
                        likeViewmodel.delete(widget.blog.id);
                      } else {
                        likeViewmodel.add(Like(
                            widget.blog.id,
                            SaveAccount.currentEmail ?? "",
                            Timestamp.fromDate(DateTime.now())));
                      }
                    },
                    icon: Icon(icon),
                    color: Colors.redAccent,
                  );
                }
                return IconButton(
                    onPressed: () {}, icon: Icon(Icons.favorite_border));
              }),
          StreamBuilder(
            stream: likeViewmodel.countLike(widget.blog.id),
            builder: (context, snapshot) => Text(snapshot.data.toString()),
          )
        ],
      ),
    );
  }

  Widget buildCommentCount() {
    return Center(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _isCommentVisible = !_isCommentVisible;
              });
            },
            icon: Icon(Icons.comment_outlined),
            color: Colors.blueAccent,
          ),
          StreamBuilder(
            stream: commentViewmodel.countComment(widget.blog.id),
            builder: (context, snapshot) => Text(snapshot.data.toString()),
          )
        ],
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
                blogViewmodel.delete(widget.blog.id);
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
    Route route = MaterialPageRoute(
      builder: (context) => EditBlog(widget.blog),
    );
    Navigator.push(context, route);
  }

  void saveBlog() {
    Timestamp time = Timestamp.fromDate(DateTime.now());
    if (SaveAccount.currentEmail != null) {
      SaveViewmodel()
          .add(Save(SaveAccount.currentEmail!, widget.blog.id, time));
    }
  }
}
