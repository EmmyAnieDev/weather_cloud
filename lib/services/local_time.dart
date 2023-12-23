import 'dart:convert';
import 'package:http/http.dart' as http;

class TimezoneService {
  static const apiKey = '0932U6M62XXT';
  static const timeZoneDBApi = 'http://api.timezonedb.com/v2.1/get-time-zone';

  Future<String> getLocalTime(double lat, double lon) async {
    String url =
        '$timeZoneDBApi?key=$apiKey&format=json&by=position&lat=$lat&lng=$lon';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      // Extract the current local time
      DateTime currentTime = DateTime.parse(data['formatted']);

      // Get only the hour and minute components
      String hour = currentTime.hour.toString().padLeft(2, '0');
      String minute = currentTime.minute.toString().padLeft(2, '0');
      String hourMinute = '$hour:$minute';
      return hourMinute;
    } else {
      throw Exception('Failed to fetch local time');
    }
  }
}
