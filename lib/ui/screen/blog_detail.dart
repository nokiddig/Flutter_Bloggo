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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: "blog-detail-${widget.blog.id}",
                child: FutureBuilder(
                  future: AccountViewModel().getByEmail(widget.blog.email),
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      String? avatar = snapshot.data?.avatarPath;
                      return Row(
                        children: [
                          CircleAvatar(
                            child: SizedBox(
                              height: 20,
                              child: Image.network(avatar??"",
                                errorBuilder: (context, error, stackTrace)
                                => Image.asset(StringConst.IMAGE_DEFAULT,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}

