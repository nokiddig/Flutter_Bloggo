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
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(
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
                            image: DecorationImage(
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
                  return CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
