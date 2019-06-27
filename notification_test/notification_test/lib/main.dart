import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode, utf8;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _str = '';
  Map<String, dynamic> _json;

  Future getData() async {
    var url = 'https://kuas.grd.idv.tw:14769/latest/notifications/1';
    var response = await http.get(url);
    setState(() {
      _str = utf8.decode(response.bodyBytes);
      _json = jsonDecode(_str);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP")),
      body: DefaultTabController(
        child: TabBarView(
          children: <Widget>[
            Container(color: Colors.red),
            Scrollbar(
              child: ListView(
                children: _renderWidgets(),
              ),
            ),
            Container(color: Colors.green),
          ],
        ),
        length: 3,
      ),
      drawer: Drawer(),
    );
  }

  List<Widget> _renderWidgets() {
    List<Widget> widgets = [];
    if (_str != '') {
      for (var i in _json['notification']) {
        widgets.add(_notification(i));
      }
    }
    return widgets;
  }

  Widget _notification(Map<String, dynamic> notification) {
    return Column(
      children: <Widget>[
        SizedBox(height: 4),
        Padding(
          child: Text(
            '${notification['info']['title']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: EdgeInsets.all(8),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '${notification['info']['department']}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '${notification['info']['date']}',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        SizedBox(height: 8),
        Container(
          color: Colors.grey,
          height: 0.5,
        ),
      ],
    );
  }
}
