import 'package:blog_app/model/category.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    List<Category> listCategory = [
      Category("Tech", "NO des",
          "https://image.shutterstock.com/image-photo/businessman-using-mobile-smart-phone-260nw-1932042689.jpg")
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: listCategory.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(listCategory[index].image),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                listCategory[index].name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}
