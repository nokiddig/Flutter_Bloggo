import 'package:blog_app/firebase_services/firebase_authentication.dart';
import 'package:blog_app/utils/constains/my_const.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../model/account.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(StringConst.IMAGE_SIGNUP), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: COLOR_CONST.WHITE,
          toolbarHeight: 40,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Create\nAccount",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              UIConst.SIZEDBOX35,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: UIConst.TEXTSTYLE_WHITE,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: COLOR_CONST.WHITE,
                      ),
                    )),
              ),
              UIConst.SIZEDBOX25,
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: UIConst.TEXTSTYLE_WHITE,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: COLOR_CONST.WHITE,
                      ),
                    )),
              ),
              UIConst.SIZEDBOX25,
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: UIConst.TEXTSTYLE_WHITE,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: COLOR_CONST.WHITE,
                      ),
                    )),
              ),
              UIConst.SIZEDBOX35,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        //singup(context);
                      },
                      child: Text(
                        "Sign Up",
                        style:
                            TextStyle(color: COLOR_CONST.WHITE, fontSize: 30),
                      )),
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                          onPressed: () {
                            singup(context);
                          },
                          icon: Icon(Icons.arrow_forward,
                            color: COLOR_CONST.WHITE,)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> singup(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Result"),
          content: FutureBuilder<bool>(
            future: registerWithEmail(email, password),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == true) {
                  registerAccount(email, password, name);
                  return const Text('Sign up successfully!');
                } else {
                  return const Text('Failed to sign up, please try again!');
                }
              }
            },
          ),
        );
      },
    );
  }

  void registerAccount(String email, String password, String name) {
    AccountViewModel viewModel = AccountViewModel();
    viewModel.addAccount(Account.clone(email, name));
  }
}
