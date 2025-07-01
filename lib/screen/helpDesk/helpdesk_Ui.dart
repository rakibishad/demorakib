import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpdeskUi extends StatelessWidget {
  const HelpdeskUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Desk"),
        centerTitle: true, // ✅ This centers the title
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        backgroundColor: Colors.blue, // Optional: improve contrast
      ),
      body: const Column(
        children: [
          Text('Help Desk Screen'),
        ],
      ),
    );
  }
}
