import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataModel1 with ChangeNotifier {
  int data = 0;
  void changeData() {
    data++;
    notifyListeners();
  }
}

class MyDataModel2 with ChangeNotifier {
  String data = "hello";
  void changeData() {
    if (data == "hello") {
      data = ", World!!";
    } else {
      data = "hello";
    }
    notifyListeners();
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<MyDataModel1>.value(
            value: MyDataModel1(),
          ), //(create: (_) => MyDataModel1()),
          ChangeNotifierProvider<MyDataModel2>(
            create: (_) => MyDataModel2(),
          ),
        ],
        child: const MyHomeWidget(),
      ),
    );
  }
}

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer2<MyDataModel1, MyDataModel2>(
            builder: (context, model1, model2, child) {
              return SubWidget1(
                model1: model1,
                model2: model2,
                child: child,
              );
            },
            child: const SubWidget2(),
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    var model1 = context.read<MyDataModel1>();
                    model1.changeData();
                  },
                  child: const Text('model1 changed')),
              ElevatedButton(
                  onPressed: () {
                    var model2 = context.read<MyDataModel2>();
                    model2.changeData();
                  },
                  child: const Text('model2 changed')),
            ],
          )
        ],
      ),
    );
  }
}

class SubWidget1 extends StatelessWidget {
  MyDataModel1 model1;
  MyDataModel2 model2;
  Widget? child;
  SubWidget1({
    Key? key,
    required this.model1,
    required this.model2,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            ' subwidget1, Model1 data : ${model1.data}, Model2 data : ${model2.data}'),
        const SizedBox(
          height: 20,
        ),
        child ?? Container(),
      ],
    );
  }
}

class SubWidget2 extends StatelessWidget {
  const SubWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('sub widget 2');
  }
}
