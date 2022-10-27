import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/networking.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  String apiKey = 'b7fe8eb4281863323d20fd563aab6c45';

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/'
        'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
  }

  Future<void> getLocation() async {
    var location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
