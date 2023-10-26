import 'package:blog_app/model/blog.dart';
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
    return buildSearchResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResult();
  }

  FutureBuilder<List<Blog>> buildSearchResult() {
    return FutureBuilder(
    future: blogViewmodel.search(query),
    builder: (context, snapshot) {
      if (snapshot.hasData){
        List<Blog> list = snapshot.data ?? [];
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 200,
              height: 90,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blog: list[index]),));
                },
                child: Stack(
                        children: [
                          Positioned(
                              width: 90,
                              height: 90,
                              top: 0,
                              left: 5,
                              child: Image.network(list[index].image)
                          ),
                          Positioned(
                            top: 10,
                            left: 100,
                            child: Text("Blog: ${list[index].title}"),),
                          Positioned(
                            top: 50,
                            left: 100,
                            child: Text(list[index].content, maxLines: 1,
                                overflow: TextOverflow.ellipsis,),),
                        ],
                      ),
              ));
          },
        );
      }
      else{
        return Center(child: CircularProgressIndicator());
      }
    }
  );
  }
}