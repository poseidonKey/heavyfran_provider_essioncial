import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProxyCreateUpdate extends StatefulWidget {
  const ProxyCreateUpdate({super.key});

  @override
  State<ProxyCreateUpdate> createState() => _ProxyCreateUpdateState();
}

class _ProxyCreateUpdateState extends State<ProxyCreateUpdate> {
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
        title: const Text('ProxyProvider Create Update'),
      ),
      body: Center(
        child: ProxyProvider0<Translations>(
          create: (_) => Translations(),
          update: (_, Translations? translations) {
            translations!.update(counter);
            return translations;
          },
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
      ),
    );
  }
}

class Translations {
  late int _value;
  void update(int newValue) {
    _value = newValue;
  }

  String get title => 'You clicked $_value times';
}

class ShowTranslations extends StatelessWidget {
  const ShowTranslations({super.key});

  @override
  Widget build(BuildContext context) {
    final title = context.watch<Translations>().title;
    print(title);
    return Text(
      title,
      style: const TextStyle(fontSize: 28),
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
