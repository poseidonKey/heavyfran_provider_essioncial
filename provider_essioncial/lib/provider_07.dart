import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/babies.dart';
import 'package:provider_essioncial/models/dog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (BuildContext context) =>
              Dog(name: 'dog06', breed: 'breed06', age: 3),
        ),
        FutureProvider(
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              final babies = Babies(age: dogAge);
              return babies.getBabies();
            },
            initialData: 0),
        StreamProvider(
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              //watch의 경우 create는 한번만 실행에서 걸린다.
              // final int dogAge = context.watch<Dog>().age;
              final babies = Babies(age: dogAge * 2);
              return babies.bark();
            },
            initialData: 'Bark 0 times'),
      ],
      child: MaterialApp(
          title: 'Provider 06',
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
        title: const Text('Provider 06'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name : ${context.watch<Dog>().name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const BreedAndAge(),
          ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '- breed : ${context.select<Dog, String>((dog) => dog.breed)}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '- age :  ${context.select<Dog, int>((Dog dog) => dog.age)}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          // 아래 두 개를 비교해 보면 read 는 처음 초기값만 보여준다.
          Text('- number of babies : ${context.watch<int>()}'),
          // Text('- number of babies : ${context.read<int>()}'),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          // read는 변화가 반영되지 않음.
          // Text('- ${context.read<String>()}'),
          Text('- ${context.watch<String>()}'),
          ElevatedButton(
            onPressed: () => context.read<Dog>().grow(),
            child: const Text('Grow'),
          ),
        ]);
  }
}
