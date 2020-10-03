import 'package:mercado_bitcoin_app/app/services/api.dart';
import 'package:mercado_bitcoin_app/app/services/api_service.dart';
import 'package:mercado_bitcoin_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  Future<EndpointData> getEndpointData(Coin coin, Method method) async =>
      await apiService.getEndpointData(
            coin: coin, method: method
            );
}
