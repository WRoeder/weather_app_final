import 'package:flutter/material.dart';
import 'Widgets/weather_tile.dart';

void main () => runApp(
  const MaterialApp(
    title: "Weather App",
    home: MyApp()
  )
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState () {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff1f1f1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "85°",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                Text(
                  "High of 89°, low of 54°",
                  style: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  WeatherTile(icon: Icons.thermostat_outlined, title: "Temperature", subtitle: "85°"),
                  WeatherTile(icon: Icons.filter_drama_outlined, title: "Weather", subtitle: "Cloudy"),
                  WeatherTile(icon: Icons.wb_sunny, title: "Humidity", subtitle: "60%"),
                  WeatherTile(icon: Icons.waves_outlined, title: "Wind Speed", subtitle: "5MPH")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

