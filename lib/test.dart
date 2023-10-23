import 'package:blog_app/ui/screen/blog/create_blog.dart';
import 'package:blog_app/viewmodel/blog_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: CreateBlog()
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
