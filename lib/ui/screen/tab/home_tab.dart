import 'package:blog_app/model/blog.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:flutter/material.dart';

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
        children: [
          Expanded(
            flex: 1,
              child: Highlight(viewmodel: viewmodel,)),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Blog blog = snapshot.data![index];
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/image3.jpg"
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/image3.jpg"
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                        child: Column(
                          children: [
                            Text(blog.title),
                            Text(blog.content),
                          ],
                        )
                    )
                  ],
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
