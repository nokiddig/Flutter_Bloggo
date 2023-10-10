import 'package:blog_app/firebase_services/firebase_authentication.dart';
import 'package:blog_app/ui/screen/signin_screen.dart';
import 'package:blog_app/viewmodel/account_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../model/account.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _emailController,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
          ),
          ElevatedButton(onPressed: (){
            CircularProgressIndicator();
            singup(context);
          }, child: Text("SignUp"))
        ],
      ),
    );
  }

  Future<void> singup(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    // if (await registerWithEmail(email, password) == true) {
    //   Route route = MaterialPageRoute(builder: (context) => SignInScreen(),);
    //   Navigator.pushReplacement(context, route);
    // } else {
    showDialog(context: context, builder:(context) {
      return AlertDialog(
        title: Text("Result"),
        content: FutureBuilder<bool>(
          future: registerWithEmail(email, password),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == true){
                registerAccount(email, password);
                return Text('Sign up successfully!');
              }
              else {
                return Text('Failed to sign up, please try again!');
              }
            }
          },
        ),
      );
    },);
  }

  void registerAccount(String email, String password) {
    AccountViewModel viewModel = AccountViewModel();
    viewModel.addAccount(Account.clone(email));
  }

}
