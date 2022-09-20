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
        body: SafeArea(
          child: SimpleCalcWidget(),
        ),
      ),
    );
  }
}

class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({super.key});

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final _model = SimpleCalcWidgetModwel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalcWidgetProwider(
          model: _model,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FirstWidget(),
              SizedBox(height: 10),
              SecondtWidget(),
              SizedBox(height: 10),
              SummButtonWidget(),
              SizedBox(height: 10),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          SimpleCalcWidgetProwider.of(context)?.model.firstNumber = value,
    );
  }
}

class SecondtWidget extends StatelessWidget {
  const SecondtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          SimpleCalcWidgetProwider.of(context)?.model.secondNumber = value,
    );
  }
}

class SummButtonWidget extends StatelessWidget {
  const SummButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => SimpleCalcWidgetProwider.of(context)?.model.sum(),
      child: const Text('Calculated'),
    );
  }
}

class ResultWidget extends StatefulWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {

  var _value = '-1';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final model = SimpleCalcWidgetProwider.of(context)?.model;
    model?.addListener(() {
      _value = '${model.sumResult}';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
  final value = SimpleCalcWidgetProwider.of(context)?.model.sumResult ?? 0;

    return Text('result = $_value');
  }
}

class SimpleCalcWidgetModwel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  void sum() {
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = null;
    }
    if (this.sumResult != sumResult) {
      sumResult = this.sumResult;
    }
    notifyListeners();
  }
}

class SimpleCalcWidgetProwider extends InheritedWidget {
  const SimpleCalcWidgetProwider(
      {super.key, required Widget child, required this.model})
      : super(child: child);

  final SimpleCalcWidgetModwel model;
  static SimpleCalcWidgetProwider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProwider>();
  }

  @override
  bool updateShouldNotify(SimpleCalcWidgetProwider oldWidget) {
    return model != oldWidget.model;
  }
}
