import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/counter.dart';
import 'package:provider_essioncial/show_me_counter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Counter _counter = Counter();
  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        '/': (context) => ChangeNotifierProvider.value(
              value: _counter,
              child: const MyHomePage(),
            ),
        '/counter': (context) => ChangeNotifierProvider.value(
              value: _counter,
              child: const ShowMeCounter(),
            ),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/counter');
            },
            child: const Text(
              'Show Me counter',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text('counter : ${context.watch<Counter>().count}'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<Counter>().increment();
            },
            child: const Text('increment'),
          ),
        ],
      ),
    );
  }
}
