import 'package:blog_app/model/blog.dart';
import 'package:blog_app/ui/screen/blog/blog_detail.dart';
import 'package:blog_app/utils/constain/font_const.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final BlogViewmodel viewmodel = BlogViewmodel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: 150,
              child: Center(child: Lottie.network("https://lottie.host/a7ff454c-f78a-41d1-a71f-a43277f5494e/o55QYBhiwd.json"))),
          Text("Highlight", style: FONT_CONST.SESSION,),
          Expanded(
            flex: 1,
              child: Highlight(viewmodel: viewmodel,)),
          Text("Feed", style: FONT_CONST.SESSION,),
          Expanded(
              flex: 3,
              child: NewFeed(viewmodel: viewmodel))
        ],
      ),
    );
  }
}

class Highlight extends StatelessWidget {
  final BlogViewmodel viewmodel;

  const Highlight({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<List<Blog>>(
        stream: viewmodel.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Blog blog = snapshot.data![index];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(blog.image,
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.9
                            ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ]
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Đã xảy ra lỗi: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );;
  }
}

class NewFeed extends StatelessWidget {
  const NewFeed({
    super.key,
    required this.viewmodel,
  });

  final BlogViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    String a = STRING_CONST.IMAGE_DEFAULT;
    return StreamBuilder<List<Blog>>(
      stream: viewmodel.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          List<Blog> data = snapshot.data ?? [];
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              Blog blog = data[index];
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: SizedBox(
                  height: 70,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blog: blog),));
                    },
                    child: Hero(
                      tag: "blog-detail-${blog.id}",
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              // height: 90,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(blog.image,),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(blog.title, style: FONT_CONST.TITLE_BLOG),
                                      Text(blog.content, style: FONT_CONST.CONTENT_BLOG,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
          },);
        }
        else if(snapshot.hasError){
          return Text("Đã xảy ra lỗi: ${snapshot.error}");
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
