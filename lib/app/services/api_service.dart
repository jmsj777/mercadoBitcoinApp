import 'dart:convert';

import 'package:mercado_bitcoin_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_bitcoin_app/app/services/api.dart';

class APIService {
  APIService(this.api);
  final API api;

  Future<EndpointData> getEndpointData({
    @required Coin coin,
    @required Method method,
  }) async {
    final uri = api.endpointUri(coin, method);
    final response = await http.get(
      uri.toString(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return EndpointData(value: data[0]);
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
