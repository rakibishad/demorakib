import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HosptalUi extends StatefulWidget {
  const HosptalUi({super.key});

  static  final city = 'Mumbai';  // Made static const
  static const pi = 3.14;        // Made static const

  @override
  State<HosptalUi> createState() => _HosptalUiState();
}

class _HosptalUiState extends State<HosptalUi> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hospital",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'City: ${HosptalUi.city}, Pi: ${HosptalUi.pi}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
