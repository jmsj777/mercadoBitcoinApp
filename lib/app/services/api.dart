
enum Coin {
  BTC,
  BCH,
  LTC,
  ETH,
}
enum Method {
  ticker,
  orderbook,
}

abstract class API {
  Uri endpointUri(Coin coin, Method method);
}

class MercadoBitcoinAPI implements API {
  MercadoBitcoinAPI();

  factory MercadoBitcoinAPI.sandbox() => MercadoBitcoinAPI();

  static final String host = 'www.mercadobitcoin.net';
  static final String basePath = 'api';

  Uri endpointUri(Coin coin, Method method) => Uri(
        scheme: 'https',
        host: host,
        path: '$basePath/${_coins[coin]}/${_methods[method]}',
      );

  static Map<Coin, String> _coins = {
    Coin.BTC: 'BTC',
    Coin.BCH: 'BCH',
    Coin.ETH: 'ETH',
    Coin.LTC: 'LTC',
  };
  static Map<Method, String> _methods = {
    Method.ticker: 'ticker',
    Method.orderbook: 'orderbook',
  };
}
