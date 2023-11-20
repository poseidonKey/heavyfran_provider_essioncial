import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Provider 09',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage());
  }
}

class Foo with ChangeNotifier {
  String value = 'Foo';
  void changeValue() {
    value = value == 'Foo' ? 'Bar' : 'Foo';
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 09'),
      ),
      body: ChangeNotifierProvider<Foo>(
        create: (BuildContext context) => Foo(),
        // 아래 주석 처리한 builder를 사용하거나 Consumer 사용한다.
        // 둘 중에 하나 상황에 맞는 것으로.
        child: Consumer<Foo>(
          builder: (_, Foo foo, __) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '- value : ${foo.value} ',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      foo.changeValue();
                    },
                    child: const Text(
                      'Change value',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // builder: (BuildContext context, Widget? child) {
        //   return Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           '- value : ${context.watch<Foo>().value} ',
        //           style: const TextStyle(fontSize: 20),
        //         ),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             context.read<Foo>().changeValue();
        //           },
        //           child: const Text(
        //             'Change value',
        //             style: TextStyle(fontSize: 20),
        //           ),
        //         ),
        //       ],
        //     ),
        //   );
        // },
      ),
    );
  }
}
