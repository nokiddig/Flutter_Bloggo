import 'package:blog_app/utils/constain/color_const.dart';
import 'package:flutter/material.dart';

import '../screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloggo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: COLOR_CONST.BLUE_DARK),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}