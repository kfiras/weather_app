import 'dart:convert';

class WeatherGrid {
  String city = '';
  String state = '';
  String office = 'TOP';
  int gridX = 31;
  int gridY = 80;

  WeatherGrid(String city, String state, String office, int gridX, int gridY) {
    this.city = city;
    this.state = state;
    this.office = office;
    this.gridX = gridX;
    this.gridY = gridY;
  }

  factory WeatherGrid.fromJsonWeatherGrid(Map<String, dynamic> json) {
    return WeatherGrid(
      json['properties']['relativeLocation']['properties']['city'],
      json['properties']['relativeLocation']['properties']['state'],
      json['properties']['gridId'],
      json['properties']['gridX'],
      json['properties']['gridY'],
    );
  }

}