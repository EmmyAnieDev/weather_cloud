import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  Network(this.url);
  final String url;

  Future getData() async {
    // get network data from the url(api)
    http.Response response = await http.get(Uri.parse(url));
    print('\n\n');

    if (response.statusCode == 200) {
      String dataFromApi = response.body;

      return jsonDecode(dataFromApi);
    } else {
      print(response.statusCode);
    }
  }
}
