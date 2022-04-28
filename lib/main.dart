import 'package:flutter/material.dart';
import 'Widgets/main_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<WeatherInfo> fetchWeather () async {
  final zipCode = "16701";
  final apiKey = "da959007a919bcdda4dff4dbff0ca98b";
  final requestUrl = "https://api.openweathermap.org/data/2.5/weather?zip=$zipCode,us&units=imperial&appid=$apiKey";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request URL info.");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['tempMax'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed']
    );
  }
}

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

  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainWidget(
              location: snapshot.data!.location,
              temp: snapshot.data!.temp,
              tempMin: snapshot.data!.tempMin,
              tempMax: snapshot.data!.tempMax,
              weather: snapshot.data!.weather,
              humidity: snapshot.data!.humidity,
              windSpeed: snapshot.data!.windSpeed,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}")
            );
          }

          return const CircularProgressIndicator();
        }
      ),
    );
  }
}

