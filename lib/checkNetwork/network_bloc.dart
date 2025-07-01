import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(ConnectionInitial()) {
    on<ListenConnection>((event, emit) {
      _subscription =
          InternetConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == InternetConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    });
    on<ConnectionChanged>((event, emit) {
     emit(event.connection);
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
