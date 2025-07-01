import 'package:flutter_bloc/flutter_bloc.dart';


import '../extra/flutter_toast.dart';
import 'network_bloc.dart';

abstract class NetworkState {}

bool checkInternetClick(context) {
  NetworkState stateOfNetwork = BlocProvider.of<NetworkBloc>(context).state;
  if (stateOfNetwork is ConnectionFailure) {
    FlutterToast.showToast("Please check internet connection");
    return false;
  }
  return true;
}

class ConnectionInitial extends NetworkState {}

class ConnectionSuccess extends NetworkState {}

class ConnectionFailure extends NetworkState {}
