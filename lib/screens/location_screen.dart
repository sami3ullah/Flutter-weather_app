import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  dynamic weatherData;

  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String city;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  updating the weather UI at starting of the app
    updateWeatherUI(widget.weatherData);
  }

  //   making an instance of weatherModel
  WeatherModel weatherModel = WeatherModel();

  void updateWeatherUI(dynamic data) {
    setState(() {
      if (data == null) {
        temperature = 0;
        city = '';
        weatherIcon = 'Error';
        weatherMessage = "Cannot get the message";
        return;
      }

      condition = data['weather'][0]['id'];
      temperature = data['main']['temp'].toInt();
      city = data['name'];
      //passing condition to get the correct emoji
      weatherIcon = weatherModel.getWeatherIcon(condition);
      // passing in temperature to get the correct message
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var data = await weatherModel.getLocationWeather();
                      updateWeatherUI(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (cityName != null) {
                        var data = await weatherModel.getCityLocation(cityName);
                        updateWeatherUI(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $city",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
