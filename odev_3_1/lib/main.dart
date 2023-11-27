import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  Color leftColor = Colors.blue;
  Color rightColor = Colors.red;

  void changeColor() {
    setState(
      () {
        leftColor = generateRandomColor();
        String colorCode =
            ' ${leftColor.value.toRadixString(16).substring(2)} ';
        // ignore: avoid_print
        print('Rastgele Renk Kodu:$colorCode');
      },
    );
  }

  void changeColor2() {
    setState(
      () {
        rightColor = generateRandomColor();
        String colorCode =
            ' ${rightColor.value.toRadixString(16).substring(2)}';
        // ignore: avoid_print
        print('Rastgele Renk Kodu:$colorCode');
      },
    );
  }

  void showPopup() {
//  void showPopup(String message) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mobil Ödev 3',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: leftColor,
                child: const Center(
                  child: Text(
                    'Sol Bölüm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: rightColor,
                child: const Center(
                  child: Text(
                    'Sağ Bölüm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  changeColor();
                },
                child: const Text('Sol Buton'),
              ),
              ElevatedButton(
                onPressed: () {
                  changeColor2();
                  showPopup(
                      //'Sağ Bölümün Rengi: ${rightColor.value.toRadixString(16).substring(2)}'
                      );
                },
                child: const Text('Sağ Buton'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
