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

class MercadoBitcoinAPI {
  MercadoBitcoinAPI();

  static final String host = 'www.mercadobitcoin.net';
  static final String basePath = 'api';

  Uri endpointUri(String coin, String method) => Uri(
        scheme: 'https',
        host: host,
        path: '$basePath/${coin}/${method}',
      );
}
