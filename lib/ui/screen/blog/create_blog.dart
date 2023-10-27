import 'package:blog_app/model/blog.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  final TextEditingController _controllerImage = TextEditingController();
  String? _selectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Blog"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            UI_CONST.SIZEDBOX30,
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Blog's title..",
                labelText: "Title",
                icon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              controller: _controllerTitle,
              validator: (value) {
                RegExp regex = RegExp(r'^.{8,}$');
                if(regex.hasMatch(value ?? "")){
                  return null;
                }
                else {
                  return "At least 8 characters.";
                }
              },
            ),
            UI_CONST.SIZEDBOX15,
            TextFormField(
              maxLines: 3,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Content",
                labelText: "Content",
                icon: Icon(Icons.content_paste_outlined),
                border: OutlineInputBorder(),
              ),
              controller: _controllerContent,
              validator: (value) {
                RegExp regex = RegExp(r'^.{100,}$');
                if(regex.hasMatch(value ?? "")){
                return null;
                }
                else {
                return "At least 100 characters.";
                }
              },
            ),
            UI_CONST.SIZEDBOX15,
            TextFormField(
              decoration: InputDecoration(
                hintText: "Image address",
                labelText: "Image",
                icon: Icon(Icons.image_outlined),
                border: OutlineInputBorder(),
              ),
              controller: _controllerImage,
              validator: (value) {

              },
            ),
            UI_CONST.SIZEDBOX15,
            DropdownButton<String>(
              icon: Icon(Icons.category_outlined),
              style: TextStyle(
                color: Colors.black,
              ),
              hint: Text("Category"),
             value: _selectedValue,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: '1',
                    child: Text('Technology'),
                  ),
                  DropdownMenuItem<String>(
                    value: '2',
                    child: Text('Science'),
                  ),
                  DropdownMenuItem<String>(
                    value: '3',
                    child: Text('Android'),
                  ),
                  DropdownMenuItem<String>(
                    value: '4',
                    child: Text('IOS'),
                  ),
                ],
                onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                },
            ),
            ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  createBlog();
                }
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  void createBlog() {
    String title = _controllerTitle.text;
    String content = _controllerContent.text;
    String image = _controllerImage.text;
    BlogViewmodel viewmodel = BlogViewmodel();
    viewmodel.add(Blog("", title, content, image, SaveAccount.currentEmail?? ''
        , _selectedValue??'1', Timestamp.fromDate(DateTime.now())));
  }
}
