import 'package:flutter/material.dart';
import 'package:game/pages/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('計數小遊戲'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '請選擇正確的運算結果',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              '點擊按鈕開始遊戲',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('開始遊戲'),
              onPressed: (){
                Navigator.push(context, GamePageRoute());
              },
            )
          ],
        )));
  }
}
