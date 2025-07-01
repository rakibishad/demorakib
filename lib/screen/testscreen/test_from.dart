

import 'package:flutter/material.dart';

class TestFrom extends StatelessWidget {
  const TestFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialDesign(); // fixed name
  }
}

class MaterialDesign extends StatelessWidget {
  const MaterialDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Material Design Example")),
      body: Center(child: Text("Hello from Material Design!")),
    );
  }
}
