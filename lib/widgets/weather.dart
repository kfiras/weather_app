import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/classes/WeatherData.dart';
import 'package:weather_app/services/weatherService.dart';

extension Round on double {
  double roundToPrecision(int n) {
    num fac = pow(10, n);
    return (this * fac).round() / fac;
  }
}

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);
  String buildTemperature(int temp, String unit) {
    if(temp == -1) {
      return 'na';
    }
    return temp.toString() + ' ' + unit;
  }
  String buildElevation(double elevation) {
    if(elevation == -1) {
      return 'na';
    }
    return elevation.roundToPrecision(2).toString() + ' meters';
  }
  Image buildIcon(String imageUrl) {
    if(imageUrl == 'na') {
       return Image.asset('assets/images/weather.png');
    }
    return Image.network(imageUrl);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WeatherService().getTodayLocalWeather(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        WeatherData weather = snapshot.data;
        return DataTable(
          columns: <DataColumn>[
            DataColumn( label: Text('Parameter'),),
            DataColumn( label: Text('Value'),),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Day')),
              DataCell(Text(weather.name))
            ]),
            DataRow(cells: [
              DataCell(Text('Temperature')),
              DataCell(Text(buildTemperature(weather.temperature,weather.temperatureUnit))),
            ]),
            DataRow(cells: [
              DataCell(Text('Wind Speed')),
              DataCell(Text(weather.windSpeed))
            ]),
            DataRow(cells: [
              DataCell(Text('Wind Direction')),
              DataCell(Text(weather.windDirection))
            ]),
            DataRow(cells: [
              DataCell(Text('Elevation')),
              DataCell(Text(buildElevation(weather.elevation))),
            ]),
            DataRow(cells: [
              DataCell(Text('City')),
              DataCell(Text(weather.city))
            ]),
            DataRow(cells: [
              DataCell(Text('State')),
              DataCell(Text(weather.state))
            ]),
            DataRow(cells: [
              DataCell(buildIcon(weather.icon)),
              DataCell(Text(weather.shortForecast))
            ]),
          ],
        );
      }
      return Container(
        padding: EdgeInsets.all(15.0),
        child: CircularProgressIndicator(),
      );
    }
    );
  }
}
