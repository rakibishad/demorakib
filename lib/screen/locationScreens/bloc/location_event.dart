abstract class LocationEvent {}

class CitySelected extends LocationEvent {
  final String city;
  CitySelected(this.city);
}

class AreaSelected extends LocationEvent {
  final String area;
  AreaSelected(this.area);
}
