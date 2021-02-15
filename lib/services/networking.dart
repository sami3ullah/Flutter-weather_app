import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String url;

  WeatherApi({this.url});

  // ========= function below calls an api to get the weather of certain location based on longitude, latitude
  Future getWeatherData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
