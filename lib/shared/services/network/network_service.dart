import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client, Response;

import 'error_response.dart';

class NetworkService {
  static Client client = Client();

  static Future<dynamic> get({required String url}) async {
    Uri uri = Uri.parse(url);
    try {
      Response response = await client.get(uri);
      switch (response.statusCode) {
        case 200 || 201 || 202 || 203 || 204:
          return jsonDecode(response.body);
        default:
          throw ErrorResponse(
            statusCode: response.statusCode,
            body: response.body,
          ).toJson();
      }
    } on SocketException {
      throw ErrorResponse.socketException().toJson();
    } on HandshakeException {
      throw ErrorResponse.handshakeException().toJson();
    } on FormatException {
      throw ErrorResponse.formatException().toJson();
    } catch (e) {
      rethrow;
    }
  }
}
