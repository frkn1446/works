import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//         ),
//         body: const Center(
//           child: Text('İsim/Soyisim : Furkan AYGÜN\nMemleket : Kahramanmaraş \nDoğum Tarihi : 19.05.2003\n'),

//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mobile Odev 2',
            style: TextStyle(
              fontSize: 24, // Metin boyutu
              fontWeight: FontWeight.bold, // Kalın yazı tipi
              color: Color.fromARGB(255, 252, 227, 0), // Metin rengi
            ),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'İsim: Furkan',
                style: TextStyle(
                  fontSize: 30, // Metin boyutu
                  fontWeight: FontWeight.bold, // Kalın yazı tipi
                  color: Color.fromARGB(255, 252, 227, 0), // Metin rengi
                ),
              ),
              Text(
                'Soyisim: AYGÜN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 252, 227, 0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Memleket: Kahramanmaraş',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                'D.Tarihi: 19.05.2003',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                'Öğrenci Numarası: 211213037',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
