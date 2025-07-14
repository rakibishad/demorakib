import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<CitySelected>((event, emit) {
      emit(LocationState(selectedCity: event.city, selectedArea: null));
    });

    on<AreaSelected>((event, emit) {
      emit(state.copyWith(selectedArea: event.area));
    });
  }
}
