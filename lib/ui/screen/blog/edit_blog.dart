import 'package:blog_app/model/blog.dart';
import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/utils/constain/my_const.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBlog extends StatefulWidget {
  Blog blog;

  EditBlog(this.blog);

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();
  final TextEditingController _controllerImage = TextEditingController();
  String? _selectedValue;

  @override
  void initState() {
    _controllerImage.text = widget.blog.image;
    _controllerTitle.text = widget.blog.title;
    _controllerContent.text = widget.blog.content;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Blog"),
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
                RegExp regex = RegExp(r'^.{5,200}$');
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
              scrollController: ScrollController(),
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
                  value: 'option1',
                  child: Text('Option 1'),
                ),
                DropdownMenuItem<String>(
                  value: 'option2',
                  child: Text('Option 2'),
                ),
                DropdownMenuItem<String>(
                  value: 'option3',
                  child: Text('Option 3'),
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
                  editBlog();
                  Navigator.pop(context);
                }
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  void editBlog() {
    String title = _controllerTitle.text;
    String content = _controllerContent.text;
    String image = _controllerImage.text;
    BlogViewmodel viewmodel = BlogViewmodel();
    viewmodel.edit(Blog(widget.blog.id, title, content, image, SaveAccount.currentEmail?? "", "1", Timestamp.fromDate(DateTime.now())));
  }
}