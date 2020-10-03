import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _low = '0';   
  String _high = '0';   
  String _vol = '0';   
  // String _asks = '0';
  // String _bids = '0';
  String _date = '0';

  Future<void> _initAttribs() async {
    final resTicker = await http.get("https://www.mercadobitcoin.net/api/BTC/ticker");
    // final resOrderBook = await http.get("https://www.mercadobitcoin.net/api/BTC/orderbook");

    Map<String, dynamic> resTickerParsed = json.decode(resTicker.body);
    final String dateString = resTickerParsed['ticker']['date'].toString();
    final date = DateTime.tryParse(dateString);
    setState(() {
      _high = resTickerParsed['ticker']['high'].substring(0,7);
      _low = resTickerParsed['ticker']['low'].substring(0,7);
      _vol = resTickerParsed['ticker']['vol'].substring(0,7);
      _date = date.toString();
      });
      
    // Map<String, dynamic> resOrderBookParsed = json.decode(resOrderBook.body);
    // final asks = resOrderBookParsed['asks'];
    // final bids = resOrderBookParsed['bids'];
    // setState(() {
      // _asks = ---;
      // _bids = ---;
    // });
      
    
  }

  @override
  Widget build(BuildContext context) {
    _initAttribs();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mais baixo nas 24h: $_low',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Mais alto nas 24h: $_high',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Volume Negociado: $_vol',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Updated in: $_date',
            )
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _initAttribs,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      )
    );
  }
}