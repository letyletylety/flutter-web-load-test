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
