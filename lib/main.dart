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
        body: OwnerStateful(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class OwnerStateful extends StatefulWidget {
  const OwnerStateful({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<OwnerStateful> createState() => _OwnerStatefulState();
}

class _OwnerStatefulState extends State<OwnerStateful> {
  var _value = 0;
  void _incrementCounter() {
    setState(() {
      _value++;
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
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          InheritDataProvider(
            value: _value,
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
            .dependOnInheritedWidgetOfExactType<InheritDataProvider>()
            ?.value ??
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
    final element =
        context.getElementForInheritedWidgetOfExactType<InheritDataProvider>();
    final provider = element?.widget as InheritDataProvider;
    final value = provider.value;
    return Text('$value');
  }
}

class InheritDataProvider extends InheritedWidget {
  const InheritDataProvider(
      {super.key, required this.value, required super.child});

  final int value;

  @override
  bool updateShouldNotify(InheritDataProvider oldWidget) {
    return value != oldWidget.value;
  }
}
