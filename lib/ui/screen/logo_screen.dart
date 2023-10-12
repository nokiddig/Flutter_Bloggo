import 'package:blog_app/services/save_account.dart';
import 'package:blog_app/ui/screen/signin_screen.dart';
import 'package:blog_app/utils/constains/my_const.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> with SingleTickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }
  /*
    Setup 1 SaveAccount for get data from sharedPreferences
    before login screen init
  */
  @override
  void initState() {
    SaveAccount();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1));

    CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: _controller, curve: Curves.easeIn);

    _animation = Tween<double>(begin: 1, end: 200)
        .animate(curvedAnimation);

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
            if (_animation.isCompleted) {
              // Khi hoàn thành animation, thực hiện chuyển hướng
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              });
            }
            return Image.asset(StringConst.IMAGE_LOGO,
              height: _animation.value,
            );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
