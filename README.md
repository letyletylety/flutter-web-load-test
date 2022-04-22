# flutter web load test

플러터 웹은 런치되면서 모든 어셋과 패키지를 다 불러오는 방식인가요?

## 테스트 환경

flutter 2.10.4

macos 12.3.1

chrome Version 100.0.4896.127

## 테스트

### 테스트에 사용할 에셋

```yaml
assets:
  - assets/create.png
  - assets/tree.jpeg
```

### 테스트에 사용할 패키지

쿠퍼티노 아이콘은 실제로는 사용하지 않고, 토글 스위치는 사용했다.

```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  toggle_switch: ^2.0.1
```

### 테스트용 코드

### main.dart

기본 카운터 예제를 수정해서 create.png 를 에셋에서 불러오는 예제

fab으로 다음 페이지로 넘어간다.

```dart
import 'package:flutter/material.dart';

import 'next.dart';

void main() {
  runApp(const MyApp());
}

const treeImage = 'assets/tree.jpeg';
const createImage = 'assets/create.png';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _moveToNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('this is first page'),
            Image.asset(createImage),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToNext,
        tooltip: 'go to next',
        child: const Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

### next.dart

다른 에셋과 ToggleSwitch 를 사용하는 코드

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/main.dart';

/// package test
import 'package:toggle_switch/toggle_switch.dart';

class NextPage extends StatelessWidget {
  const NextPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('this is next page'),
            // load image test
            Image.asset(treeImage),
            ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 3,
              labels: ['America', 'Canada', 'Mexico'],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 테스트 결과

> flutter run —release 로 테스트

### main.dart
