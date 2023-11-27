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
  String text = ''; // Kullanıcı girişi için bir değişk
  final TextEditingController _controller = TextEditingController();
  List<String>? column1Text;
  List<String>? column2Text;
  List<String>? column3Text;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Bu fonksiyon metni alıp ilgili sütuna yerleştiriyor
  void distributeText(String inputText, int columnNumber) {
    setState(
      () {
        switch (columnNumber) {
          case 4:
            column1Text = getCombinations(inputText, 4);
            break;
          case 5:
            column2Text = getCombinations(inputText, 5);
            break;
          case 6:
            column3Text = getCombinations(inputText, 6);
            break;
        }
      },
    );
  }

  List<String> getCombinations(String input, int length) {
    if (length == 0) {
      return [''];
    }
    if (input.isEmpty) {
      return [];
    }
    List<String> combinations = [];
    for (int i = 0; i < input.length; i++) {
      List<String> subCombinations = getCombinations(
          input.substring(0, i) + input.substring(i + 1), length - 1);
      for (String s in subCombinations) {
        combinations.add(input[i] + s);
      }
    }
    return combinations;
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata yapıldı'),
          content:
              const Text('Yalnızca harf giriniz. Minimum 6 harf olmalıdır!'),
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

  bool shouldWarnUser(String input) {
    if (input.length < 6) {
      return true;
    }

    // Metinde yalnızca harfler olup olmadığını kontrol et.
    for (int rune in input.runes) {
      var character = String.fromCharCode(rune);
      if (!character.contains(RegExp(r'[a-zA-Z]'))) {
        // Eğer karakter bir harf değilse (sayı veya sembol içeriyorsa) uyar.
        return true;
      }
    }

    // Eğer herhangi bir uyarı durumu yoksa false dön.
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Mobil Ödev 4',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            // Oval şekilli metin girme alanı
            Center(
              child: Container(
                width: 360, // Örnek bir genişlik değeri
                height: 70, // Örnek bir yükseklik değeri
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(190.0), // Yuvarlak köşeler
                  color: Colors.red,
                ),
                child: Center(
                  child: Container(
                      width: 150, // Örnek bir genişlik değeri
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
                          height: 60.0, // Yeterli yükseklik değerini ayarlayın
                          child: TextFormField(
                            autofocus: true,
                            controller: _controller,
                            textAlign:
                                TextAlign.center, // Metni yatay eksende ortalar
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
            const SizedBox(height: 40),
            // 3 eşit sütuna bölme
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Sütun 1
                  buildColumn('Sütun 1', column1Text),
                  // Sütun 2
                  buildColumn('Sütun 2', column2Text),
                  // Sütun 3
                  buildColumn('Sütun 3', column3Text),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (shouldWarnUser(_controller.text)) {
                  showPopup();
                } else {
                  distributeText(_controller.text, 4);
                }
              },
              child: const Text('4 harf'),
            ),
            ElevatedButton(
              onPressed: () {
                if (shouldWarnUser(_controller.text)) {
                  showPopup();
                } else {
                  distributeText(_controller.text, 5);
                }
              },
              child: const Text('5 harf'),
            ),
            ElevatedButton(
              onPressed: () {
                if (shouldWarnUser(_controller.text)) {
                  showPopup();
                } else {
                  distributeText(_controller.text, 6);
                }
              },
              child: const Text('6 harf'),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildColumn(String title, List<String>? content) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.all(8.0), // Padding eklendi.
                  child: content != null
                      ? Column(
                          children: content
                              .map((item) => Text(
                                    item,
                                    textAlign: TextAlign.center,
                                  ))
                              .toList(),
                        )
                      : const Center(
                          child: Text(
                            'Liste boş',
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
