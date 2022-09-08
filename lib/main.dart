import 'package:flutter/material.dart';
import 'dart:math';
// models
import 'models/colored_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApplication(),
    );
  }
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  // int counter = 1;
  // List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  late ValueNotifier<int> _counterNotifier;
  late ValueNotifier<List<ColoredBar>> _barsNotifier;

  @override
  void initState() {
    super.initState();
    _counterNotifier = ValueNotifier(1);
    _barsNotifier = ValueNotifier([const ColoredBar(color: Colors.lightBlueAccent)]);
  }

  Color getRandomColor() {
    List<Color> storedColors = [Colors.red, Colors.blue, Colors.green, Colors.cyan, Colors.purple, Colors.yellow];
    return storedColors[Random().nextInt(storedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterNotifier.value++;
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Counter App',
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Value Listenable Builder are used to listen to the changes in the value notifier...
              ValueListenableBuilder(
                valueListenable: _barsNotifier,
                builder: (_, List<ColoredBar> barsList, __) {
                  return FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...barsList
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              ValueListenableBuilder(
                  valueListenable: _counterNotifier,
                  builder: (_, int value, __) {
                    return Center(
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () {
                  _barsNotifier.value = [
                    ..._barsNotifier.value, ColoredBar(color: getRandomColor()),
                  ];
                },
                backgroundColor: Colors.cyan,
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _counterNotifier.dispose();
    _barsNotifier.dispose();
    super.dispose();
  }
}
