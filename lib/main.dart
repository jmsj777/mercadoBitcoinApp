import 'package:flutter/material.dart';

import 'app/ui/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.black54,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.white70),
            canvasColor: Colors.green),
        home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/watermark.png"),
                fit: BoxFit.scaleDown,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                alignment: Alignment.bottomLeft),
          ),
          child: MyHomePage(title: 'Mercado Bitcoin App'),
        ));
  }
}
