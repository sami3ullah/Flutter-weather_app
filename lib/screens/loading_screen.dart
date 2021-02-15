import 'package:flutter/material.dart';
import '../services/weather.dart';
import '../services/weather.dart';
import '../services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double longitude;
  double latitude;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  // ======== function below gets the location in longitude & latitude =======
  void getLocation() async {
    var data = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: data,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        size: 100.0,
        color: Colors.white,
      )),
    );
  }
}
