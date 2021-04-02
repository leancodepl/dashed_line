import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = Path()..cubicTo(-40, 53, 14, 86, 61, 102);

    return Scaffold(
      appBar: AppBar(
        title: const Text('dashed_line example'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.celebration),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(
            'Click me!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(72, 0, 72, 64),
              child: DashedLine(
                path: path,
                color: Theme.of(context).textTheme.headline4!.color!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
