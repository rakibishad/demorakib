import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';



// dashboard_state.dart
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final String message;

  const DashboardState({this.message = ''});

  @override
  List<Object?> get props => [message]; // ✅ This line fixes the error
}

