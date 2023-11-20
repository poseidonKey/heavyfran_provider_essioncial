import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_essioncial/models/counter.dart';

class ShowMeCounter extends StatelessWidget {
  const ShowMeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${context.watch<Counter>().count}',
        style: const TextStyle(fontSize: 52),
      ),
    );
  }
}
