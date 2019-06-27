import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "TEST",
            ),
            ClipOval(
              child: Image.asset(
                "images/49203.jpg",
                width: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
