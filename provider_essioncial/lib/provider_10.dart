import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/dog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (BuildContext context) =>
          Dog(name: 'dog10', breed: 'breed10', age: 3),
      child: MaterialApp(
          title: 'Provider 10',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 10'),
      ),
      body: Selector<Dog, String>(
        selector: (BuildContext context, Dog dog) => dog.name,
        builder: (_, String name, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                Text(
                  '- name : $name',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BreedAndAge(),
              ],
            ),
          );
        },
        child: const Text(
          ' I like dogs very much',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Dog, String>(
        selector: (BuildContext context, Dog dog) => dog.breed,
        builder: (_, String breed, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '- breed : $breed',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Age(),
            ],
          );
        });
  }
}

class Age extends StatelessWidget {
  const Age({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<Dog, int>(
        selector: (BuildContext context, Dog dog) => dog.age,
        builder: (_, int age, __) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '- age :  $age',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => context.read<Dog>().grow(),
                  child: const Text('Grow'),
                ),
              ]);
        });
  }
}
