import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataModel with ChangeNotifier {
  int data1 = 0;
  int data2 = 10;
  String data3 = 'my String';
  void changeData1() {
    data1++;
    notifyListeners();
  }

  void changeData2() {
    data2++;
    notifyListeners();
  }
}

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
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<MyDataModel>.value(
              value: MyDataModel(),
            )
          ],
          child: const HomeWidget(),
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          Consumer<MyDataModel>(builder: (context, model, child) {
            return Container(
              child: Text(
                  'consumer, data1 : ${model.data1}, data2: ${model.data2}'),
            );
          }),
          Selector<MyDataModel, String>(
              builder: (context, data, child) {
                return Container(
                  child: Text(' selector : $data'),
                );
              },
              selector: (context, model) => model.data3),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Provider.of<MyDataModel>(context, listen: false)
                        .changeData1();
                  },
                  child: const Text('data 1 change')),
              ElevatedButton(
                  onPressed: () {
                    context.read<MyDataModel>().changeData2();
                  },
                  child: const Text('data 2 change')),
            ],
          )
        ],
      ),
    );
  }
}
