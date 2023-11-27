import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 1;

  void _incrementCounter(int sign) {
    setState(() {
      if (sign == 1) {
        _counter *= 2;
      }
      if (sign == 2) {
        double karekok = sqrt(_counter.toDouble());
        if (karekok % 1 == 0) {
          _counter = karekok; // Sonuç tamsayı ise tamsayı olarak döndürülür.
        } else {
          _counter = karekok; // Sonuç ondalık ise küsüratıyla döndürülür.
        }
      }
      if (sign == 3) {
        _counter = 1;
      }
    });
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup'),
          content: const Text("asd"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Mobil Progamlama Ödev2.2',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: const TextStyle(
                  fontSize: 40), // Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _incrementCounter(1);
              },
              child: const Text('X2'),
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter(2);
                showPopup();
              },
              child: const Text('Kök al'),
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter(3);
              },
              child: const Text('! 1 !'),
            ),
          ],
        ),
      ),
    );
  }
}
