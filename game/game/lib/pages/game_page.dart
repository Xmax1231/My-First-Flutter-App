import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/pages/result_page.dart';

final _random = new Random();
int next(int min, int max) => min + _random.nextInt(max - min);

class GamePageRoute extends MaterialPageRoute {
  GamePageRoute()
      : super(builder: (_) {
          return GamePage();
        });
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int liveTime;
  int playLevel;
  int a, b;
  int offsetA, offsetB;
  var nowItems;

  @override
  void initState() {
    liveTime = 15000;
    playLevel = 1;
    a = next(0, 100);
    b = next(0, 100);
    offsetA = getOffset(0);
    offsetB = getOffset(offsetA);
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (liveTime <= 0.1) {
        timer.cancel();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(playLevel);
          }),
        );
      } else {
        setState(() {
          liveTime -= 100;
        });
      }
    });
    super.initState();
    nowItems = getItems();
  }

  int getOffset(int anotherOffset) {
    int offsetRange = playLevel + 1;
    int tempOffset = next(-offsetRange, offsetRange);
    while ((tempOffset == 0) || (tempOffset == anotherOffset)) {
      tempOffset = next(-offsetRange, offsetRange) + next(0, offsetRange);
    }
    return tempOffset;
  }

  List<Widget> getItems() {
    var items = [
      FlatButton(
        child: Text('${a + b + offsetA}'),
        onPressed: () {
          setState(() {
            liveTime -= 1000;
          });
        },
      ),
      FlatButton(
        child: Text('${a + b}'),
        onPressed: () {
          setState(() {
            a = next(0, 100);
            b = next(0, 100);
            offsetA = getOffset(0);
            offsetB = getOffset(offsetA);
            nowItems = getItems();
            playLevel += 1;
            if (playLevel % 5 == 0) {
              liveTime += 5000;
            }
          });
        },
      ),
      FlatButton(
        child: Text('${a + b + offsetB}'),
        onPressed: () {
          setState(() {
            liveTime -= 1000;
          });
        },
      ),
    ];
    return shuffle(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('第 $playLevel 層'),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '剩餘時間：${max(liveTime / 1000.0, 0)} 秒',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 16),
              Text(
                '$a + $b = ?',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: nowItems,
              )
            ],
          ),
        ));
  }
}

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
