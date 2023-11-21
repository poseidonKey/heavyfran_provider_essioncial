import 'package:flutter/material.dart';

class Translations {
  final int _value;
  Translations(this._value);
  String get title => 'You clicke $_value times';
}

class MyProxyProv extends StatefulWidget {
  const MyProxyProv({super.key});

  @override
  State<MyProxyProv> createState() => _MyProxyProvState();
}

class _MyProxyProvState extends State<MyProxyProv> {
  int counter = 0;
  void increment() {
    setState(() {
      counter++;
      print('counter : $counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why ProxyProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ShowTranslations(),
            const SizedBox(
              height: 20,
            ),
            IncreaseButton(increment: increment),
          ],
        ),
      ),
    );
  }
}

class ShowTranslations extends StatelessWidget {
  const ShowTranslations({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You clicked 0 time',
      style: TextStyle(fontSize: 28),
    );
  }
}

class IncreaseButton extends StatelessWidget {
  final VoidCallback increment;
  const IncreaseButton({
    Key? key,
    required this.increment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: increment,
      child: const Text(
        'Increase',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
