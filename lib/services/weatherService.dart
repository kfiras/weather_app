import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_demo/classes/WeatherData.dart';
import 'package:simple_demo/classes/WeatherGrid.dart';
import 'geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String buildPositionQueryString(Position position) {
    return position.latitude.toString() + ',' + position.longitude.toString();
  }

  String buildGridQueryString(WeatherGrid grid) {
    return grid.office +
        '/' +
        grid.gridX.toString() +
        ',' +
        grid.gridY.toString() +
        '/forecast';
  }

  Future<WeatherData> getTodayLocalWeather() async {
    var grid = await getGridParameters();
    http.Response response;
    Uri uri = Uri.parse(
        'https://api.weather.gov/gridpoints/' + buildGridQueryString(grid));
    response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    if(response.statusCode != 200) {
     return WeatherData('na', -1, 'na', 'na', 'na', 'na', -1,'na', 'na', 'na');
    }
    print('https://api.weather.gov/gridpoints/' + buildGridQueryString(grid));
    var weather = WeatherData.fromJsonWeatherData(jsonDecode(response.body));
    weather.city = grid.city;
    weather.state = grid.state;
    return weather;
  }

  Future<WeatherGrid> getGridParameters() async {
    var position = await GeoService().determinePosition();
    http.Response response;
    Uri uri = Uri.parse(
        'https://api.weather.gov/points/' + buildPositionQueryString(position));
    response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    return WeatherGrid.fromJsonWeatherGrid(jsonDecode(response.body));
  }
}
