import 'package:blog_app/model/blog.dart';
import 'package:flutter/material.dart';

class EditBlog extends StatefulWidget {
  Blog blog;
  EditBlog(this.blog);

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  @override
  Widget build(BuildContext context) {
    return Text("Edit Blog");
  }
}
