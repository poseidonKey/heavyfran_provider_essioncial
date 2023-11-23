import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CounterGG>(
            create: (context) => CounterGG(),
          ),
          ProxyProvider<CounterGG, Sum>(update: (context, model, sum) {
            if (sum != null) {
              sum.sum = model.count;
              return sum;
            } else {
              return Sum(model);
            }
          }),
          ProxyProvider2<CounterGG, Sum, String>(
              update: (context, model1, model2, str) {
            return 'count : ${model1.count}, ${model2.sum}';
          }),
          // ProxyProvider0<String>(update: (context, String) {
          //   return 'aa';
          // }),
        ],
        child: const SubWidget(),
      ),
    );
  }
}

class SubWidget extends StatelessWidget {
  const SubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var counter =
        context.watch<CounterGG>(); // Provider.of<CounterGG>(context);
    var sum = Provider.of<Sum>(context);
    var str = Provider.of<String>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                ' Result!!',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' counter : ${counter.count}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                ' Sum.sum : ${sum.sum}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                ' string : $str',
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    counter.increment();
                  },
                  child: const Text('counter increment'))
            ],
          ),
        ),
      ),
    );
  }
}

class CounterGG with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

class Sum {
  int _sum = 0;
  int get sum => _sum;
  Sum(CounterGG counter) {
    sum = counter.count;
  }
  set sum(int value) {
    _sum = 0;
    for (int i = 1; i <= value; i++) {
      _sum += i;
    }
  }
}
