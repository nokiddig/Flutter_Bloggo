import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("A"),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: "Hehe"),
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: "Hehe1"),
          BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Hehe2"
          ),
        ],
      ),
    );
  }
}
