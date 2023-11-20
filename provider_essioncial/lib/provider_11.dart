import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/counter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: ChangeNotifierProvider<Counter>(
          create: (_) => Counter(),
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          // 두번 째 -> 아래와 같이 별도의 위젯으로 처리하는 방법
          // child: const ChildWidget(),
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
  }
}
