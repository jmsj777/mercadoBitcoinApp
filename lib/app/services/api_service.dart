import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_bitcoin_app/app/services/api.dart';

class APIService {
  APIService(this.api);
  final MercadoBitcoinAPI api;

  Future<Map<String, dynamic>> getEndpointData({
    @required String coin,
    @required String method,
  }) async {
    final uri = api.endpointUri(coin, method);
    final response = await http.get(
      uri.toString(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data;
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
