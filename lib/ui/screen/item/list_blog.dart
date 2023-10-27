import 'package:flutter/material.dart';
import '../../../model/blog.dart';
import '../blog/blog_detail.dart';

class ListViewBlogScreen extends StatelessWidget{
  Future<List<Blog>> future;

  ListViewBlogScreen(this.future);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListViewBlog(future),
    );
  }

}

class ListViewBlog extends StatelessWidget {
  ListViewBlog(this.future);

  Future<List<Blog>> future;

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: future,
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
