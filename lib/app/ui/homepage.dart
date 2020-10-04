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
  List _asks;
  List _bids;
  String _date = '0';

  String _dropDownValue = 'BTC';

  Future<void> _initAttribs() async {
    final resTicker = await http.get("https://www.mercadobitcoin.net/api/$_dropDownValue/ticker");
    final resOrderBook = await http.get("https://www.mercadobitcoin.net/api/$_dropDownValue/orderbook");

    Map<String, dynamic> resTickerParsed = json.decode(resTicker.body);
    final dateString = resTickerParsed['ticker']['date'];
    final date = DateTime.fromMicrosecondsSinceEpoch(dateString * 1000000);
    // print(date);
    setState(() {
      _high = resTickerParsed['ticker']['high'].substring(0,7);
      _low = resTickerParsed['ticker']['low'].substring(0,7);
      _vol = resTickerParsed['ticker']['vol'].substring(0,7);
      
      _date = '${date.day}/${date.month}, at ${date.hour}:${date.minute}';
       });
      
    Map<String, dynamic> resOrderBookParsed = json.decode(resOrderBook.body);

    var resAsks = resOrderBookParsed['asks'];
    var resBids = resOrderBookParsed['bids'];
    var listArrayAsks = new List<Widget>();
    var listArrayBids = new List<Widget>();
    
    for (var i = 0; i < 20; i++) {
      listArrayAsks.add(new Text('${resAsks[i][0].toStringAsFixed(1)}  /  ${resAsks[i][1].toStringAsFixed(6)}'));
      listArrayBids.add(new Text('${resBids[i][0].toStringAsFixed(1)}  /  ${resBids[i][1].toStringAsFixed(6)}'));
    }

    print(listArrayAsks.runtimeType);
    print(listArrayAsks[0].runtimeType);
    setState(() {
      _asks = listArrayAsks;
      _bids = listArrayBids;
    });
      
    
  }

  @override
  Widget build(BuildContext context) {
    // _initAttribs();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
            DropdownButton<String>(
              value: _dropDownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Colors.deepPurple
              ),
              
              onChanged: (String newValue) {
                setState(() {
                  _dropDownValue = newValue;
                });
              },
              items: <String>['BTC', 'BCH', 'ETH', 'LTC']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
            ),
            Padding(padding: EdgeInsets.all(10)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[   
              Padding(padding: EdgeInsets.all(10)),       
              Text(
                'Mínimo nas últimas 24h: $_low',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                'Máximo nas últimas 24h: $_high',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                'Volume Negociado: $_vol',
                style: Theme.of(context).textTheme.headline5,
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      children: <Widget>[
                        Text("Ordens de compra (val  /  qty): "),
                        for(var item in _asks)
                          item,
                      ]
                  ),
                  Column(
                      children: [
                        Text("Ordens de venda (val  /  qty): "),
                        for(var i=0; i<_bids.length; i++)
                          _bids[i],
                      ]
                  ),
                ]
              ),
            ],
          ),
          
          Text(
            'Updated in: $_date',
          )
        ],
      ),
    
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: _initAttribs,
        tooltip: 'Increment',
        child: Icon(Icons.search),
      )
    );
  }
}