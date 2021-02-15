import 'location.dart';
import 'networking.dart';
import 'networking.dart';

class WeatherModel {
  String apiKey = 'f004d434af93c09f258c9f61b5fa7859';
  String apiEndPoint = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityLocation(String cityName) {
    var url = '$apiEndPoint?q=$cityName&appid=$apiKey&units=metric';
    WeatherApi weatherApi = WeatherApi(url: url);

    dynamic data = weatherApi.getWeatherData();
    return data;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    //weather class defined in networking
    WeatherApi weatherApi = WeatherApi(
        url:
            '$apiEndPoint?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    // getting the response of the request
    dynamic data = await weatherApi.getWeatherData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
