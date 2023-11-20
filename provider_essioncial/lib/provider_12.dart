import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/counter.dart';
import 'package:provider_essioncial/show_me_counter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider(
        create: (BuildContext context) => Counter(),
        child: const MyHomePage(),
      ),
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
      body: ChangeNotifierProvider<Counter>(
        create: (_) => Counter(),
        child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<Counter>(),
                          child: const ShowMeCounter()),
                      // 아래와 같이 하면 오류 발생.  buildContext가 같으면 안됨.
                      //context를 상위 것이 아닌 다른 것 예)countContext 등으로 바꿔처리
                      // 아니면 위와 같이 사용하지 않으므로 _ 로 처리해 사용하는 것도 방법
                      // builder: (context) => const ShowMeCounter(),
                    ),
                  );
                },
                child: const Text(
                  'Show me counter',
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
          );
        }),
      ),
    );
  }
}
