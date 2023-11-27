import 'dart:math';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
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

  Color leftColor = Colors.white;
  Color rightColor = Colors.red;
  Color leftStringColor = Colors.black;
  Color rightStringColor = Colors.black;

  bool isColorNearBlackOrWhite(String colorHex) {
    Color color = Color(int.parse(colorHex.replaceAll("#", ""), radix: 16));
    double luminance =
        0.299 * color.red + 0.587 * color.green + 0.114 * color.blue;

    return luminance <
        128; // Eşik değeri, 128 olarak ayarlandı, bu değeri gerektiğiniz gibi ayarlayabilirsiniz.
  }

  void changeColor() {
    setState(
      () {
        leftColor = generateRandomColor();
        String colorCode =
            ' ${leftColor.value.toRadixString(16).substring(2)} ';
        showPopup(colorCode);
        if (isColorNearBlackOrWhite(colorCode)) {
          leftStringColor = Colors.white;
        } else {
          leftStringColor = Colors.black;
        }
      },
    );
  }

  void changeColor2() {
    setState(
      () {
        rightColor = generateRandomColor();
        String colorCode =
            ' ${rightColor.value.toRadixString(16).substring(2)}';
        showPopup(colorCode);
        if (isColorNearBlackOrWhite(colorCode)) {
          rightStringColor = Colors.white;
        } else {
          rightStringColor = Colors.black;
        }
      },
    );
  }

  void showPopup(String clr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Renk değişti'),
          content: Text('renk kodu $clr'),
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
                child: Center(
                  child: Text(
                    'Sol Bölüm',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: leftStringColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: rightColor,
                child: Center(
                  child: Text(
                    'Sağ Bölüm',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: rightStringColor),
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
//                  showPopup();
                },
                child: const Text('Sol Buton'),
              ),
              ElevatedButton(
                onPressed: () {
                  changeColor2();
                  //                 showPopup();
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


//               ElevatedButton(
//                 onPressed: () {
//                   changeColor2();
//                   //                 showPopup();
//                 },
//                 child: const Text('Sağ Buton'),
//               ),


// basıldığında ekranın üstünde snackbar çıkmalı