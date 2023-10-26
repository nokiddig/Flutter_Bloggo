import 'package:blog_app/model/blog.dart';
import 'package:blog_app/ui/screen/item/list_blog.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:flutter/material.dart';

import 'blog/blog_detail.dart';

class CustomSearch extends SearchDelegate {
  BlogViewmodel blogViewmodel = BlogViewmodel();

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
    return ListViewBlog(blogViewmodel.search(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListViewBlog(blogViewmodel.search(query));
  }
}