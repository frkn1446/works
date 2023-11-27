import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mobil Odev 5'),
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
  final TextEditingController _controller = TextEditingController();

  String txt = '';
  int a = 19;
  late List<Color> colors = List.generate(16, (_) => getRandomColor());

  Color getRandomColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  Random random = Random(); // Rastgele sayı üreteci oluştur

  void changeColor(int index) {
    setState(() {
      colors[index] = getRandomColor();
    });
  }

  // void changeColor() {
  //   setState(() {
  //     // Rastgele bir renk oluştur
  //     clr = Color.fromRGBO(
  //       random.nextInt(256), // Kırmızı için 0-255 arası rastgele bir sayı
  //       random.nextInt(256), // Yeşil için 0-255 arası rastgele bir sayı
  //       random.nextInt(256), // Mavi için 0-255 arası rastgele bir sayı
  //       1, // Alfa değeri (opacity), tam opaklık için 1
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    colors =
        List.generate(16, (_) => getRandomColor()); // initState içinde başlatın
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Mobil Ödev 5',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 100,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 360, // Örnek bir genişlik değeri
                      height: 90, // Örnek bir yükseklik değeri
                      child: Center(
                        child: Container(
                            width: 350, // Örnek bir genişlik değeri
                            height: 40, // Örnek bir yükseklik değeri
                            decoration: BoxDecoration(
                              // borderRadius:
                              //     BorderRadius.circular(20.0), // Yuvarlak köşeler
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                height:
                                    60.0, // Yeterli yükseklik değerini ayarlayın
                                child: TextFormField(
                                  controller: _controller,
                                  autofocus: true,
                                  textAlign: TextAlign
                                      .center, // Metni yatay eksende ortalar
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // Çerçevesiz bir giriş alanı
                                    hintText: 'Text',
                                  ),
                                  style: const TextStyle(
                                    height:
                                        1.0, // Bu, metnin dikey eksende ortalanmasına yardımcı olabilir
                                  ),
                                  maxLines: 1, // Tek satır metin için
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        txt = _controller.text;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      'Buton',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        a = a * 2;
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        a = 10;
                      });
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      // Sabit boyutları ayarlayın
                      width: 350, // Örnek bir genişlik değeri
                      height: 250, // Örnek bir yükseklik değeri
                      child: SingleChildScrollView(
                        child: Text(
                          txt,
                          style: TextStyle(
                            fontSize: a.toDouble(),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 63, // GridView için kullanılacak alanın oranını ayarlar
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Her satırda kaç hücre olacağını belirler
                childAspectRatio: 1.4, // Hücrelerin en-boy oranı
                crossAxisSpacing: 2, // Yatay hücreler arası boşluk
                mainAxisSpacing: 2, // Dikey hücreler arası boşluk
              ),
              itemCount: 16, // Toplam hücre sayısı
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      changeColor(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index], // Hücre arkaplan rengi
                      border: Border.all(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
