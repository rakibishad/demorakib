
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HosptalUi extends StatefulWidget {
  const HosptalUi({super.key});

  @override
  State<HosptalUi> createState() => _HosptalUiState();
}

class _HosptalUiState extends State<HosptalUi> {
  @override
  Widget build(BuildContext context) {
    return Material(
child: Scaffold(
        appBar: AppBar(
   title: const Text("Hospital" ,style: TextStyle(color: Colors.white),),),
    ),

    );
  }
}
