// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: OwnerStateful(),
      ),
    );
  }
}

class OwnerStateful extends StatefulWidget {
  const OwnerStateful({
    Key? key,
  }) : super(key: key);

  @override
  State<OwnerStateful> createState() => _OwnerStatefulState();
}

class _OwnerStatefulState extends State<OwnerStateful> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrementCounterOne() {
    setState(() {
      _valueOne++;
    });
  }

  void _incrementCounterTwo() {
    setState(() {
      _valueTwo++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          ElevatedButton(
            onPressed: _incrementCounterOne,
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: _incrementCounterTwo,
            child: const Icon(Icons.add),
          ),
          InheritDataProvider(
            valueOne: _valueOne,
            valueTwo: _valueTwo,
            child: const ConsumerStateless(),
          ),
        ],
      ),
    );
  }
}

class ConsumerStateless extends StatelessWidget {
  const ConsumerStateless({super.key});
  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<InheritDataProvider>(
              aspect: 'one',
            )
            ?.valueOne ??
        0;
    return Center(
      child: Column(
        children: [
          Text('$value'),
          const StatefulConsumer(),
        ],
      ),
    );
  }
}

class StatefulConsumer extends StatefulWidget {
  const StatefulConsumer({Key? key}) : super(key: key);

  @override
  State<StatefulConsumer> createState() => _StatefulConsumerState();
}

class _StatefulConsumerState extends State<StatefulConsumer> {
  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<InheritDataProvider>(
              aspect: 'two',
            )
            ?.valueTwo ??
        0;
    return Text('$value');
  }
}

class InheritDataProvider extends InheritedModel<String> {
  const InheritDataProvider(
      {super.key,
      required this.valueOne,
      required this.valueTwo,
      required super.child});

  final int valueOne;
  final int valueTwo;

  @override
  bool updateShouldNotify(covariant InheritDataProvider oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritDataProvider oldWidget, Set<String> dependencies) {
    final isValueOneUpdate =
        valueOne != oldWidget.valueOne && dependencies.contains('one');

    final isValueTwoUpdate =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdate || isValueTwoUpdate;
  }
}
