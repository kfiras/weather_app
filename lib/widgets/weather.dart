import 'package:flutter/material.dart';
import 'package:simple_demo/classes/WeatherData.dart';
import 'package:simple_demo/services/weatherService.dart';
class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

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
              DataCell(Text(weather.temperature.toString() + ' ' + weather.temperatureUnit))
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
              DataCell(Text(weather.elevation.toString() + ' meters'))
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
              DataCell(Image.network(weather.icon)),
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
