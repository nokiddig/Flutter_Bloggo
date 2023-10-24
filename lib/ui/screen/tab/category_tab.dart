import 'package:blog_app/model/category.dart';
import 'package:blog_app/viewmodel/category_viewmodel.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  CategoryViewmodel categoryViewmodel = CategoryViewmodel();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: categoryViewmodel.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<Category>? list = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(list[index].image),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      list[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                );
              },
            );
          }
          else if (snapshot.hasError){
            return Text("Loi doc category ${snapshot.error}");
          }
          else {
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
