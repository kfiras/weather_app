import 'dart:ffi';

class WeatherData {
  String name = 'Today';
  String temperatureUnit = 'F';
  String windSpeed = '';
  String windDirection = '';
  String shortForecast = '';
  int temperature = 70;
  double elevation = 0;
  String city = '';
  String state = '';

  WeatherData(String name, int temperature, String temperatureUnit,
              String windSpeed, String windDirection, String shortForecast, double elevation, String city, String state) {
    this.name = name;
    this.temperature = temperature;
    this.temperatureUnit = temperatureUnit;
    this.windSpeed = windSpeed;
    this.windDirection = windDirection;
    this.shortForecast = shortForecast;
    this.elevation = elevation;
    this.city = city;
    this.state = state;
  }

  factory WeatherData.fromJsonWeatherData(Map<String, dynamic> json) {
    return WeatherData(
      json['properties']['periods'][0]['name'],
      json['properties']['periods'][0]['temperature'],
      json['properties']['periods'][0]['temperatureUnit'],
      json['properties']['periods'][0]['windSpeed'],
      json['properties']['periods'][0]['windDirection'],
      json['properties']['periods'][0]['shortForecast'],
      json['properties']['elevation']['value'],
      '',
      '',
    );
  }
}