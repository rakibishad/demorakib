import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.light}); // Default theme = light theme

  final ThemeMode themeMode;
  ThemeState copyWith({ThemeMode? themeMode}) => ThemeState(
    themeMode: themeMode ?? this.themeMode,
  );

  @override
  List<Object?> get props => [themeMode];
}