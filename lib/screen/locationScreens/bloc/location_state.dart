class LocationState {
  final String? selectedCity;
  final String? selectedArea;

  LocationState({this.selectedCity, this.selectedArea});

  LocationState copyWith({String? selectedCity, String? selectedArea}) {
    return LocationState(
      selectedCity: selectedCity ?? this.selectedCity,
      selectedArea: selectedArea ?? this.selectedArea,
    );
  }
}
