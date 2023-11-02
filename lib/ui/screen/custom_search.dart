import 'package:blog_app/ui/screen/item/list_blog.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  BlogViewmodel blogViewmodel = BlogViewmodel();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      query = '';
    }, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
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