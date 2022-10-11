import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    Uri uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        default:
          return response.statusCode;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
