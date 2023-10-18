import 'package:blog_app/model/account.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:flutter/material.dart';

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

  ABlogDetail(this.blog, {super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "blog-detail-${blog.id}",
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                              Text(name ?? "name"),
                              Text(email ?? "email"),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            Image.network(blog.image),
            Text(blog.title, style: FONT_CONST.TITLE_BLOG),
            Text(blog.content, style: FONT_CONST.CONTENT_BLOG,
            ),
          ],
        ),
      ),
    );
  }
}
