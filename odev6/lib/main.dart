import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobil Odev6'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'grafik bilgileri') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GrafikBilgileri()),
                );
              }
              if (value == 'grafik') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GrafikGoruntusu(
                      xValues: [1, 2, 3, 4, 5],
                      yValues: [1, 2, 3, 4, 5],
                      leftTitle: 'sol',
                      bottomTitle: 'alt',
                    ),
                  ),
                );
              }

              // Popup menü seçeneklerinin işlevlerini burada tanımlayın GrafikGoruntusu
            },
            itemBuilder: (BuildContext context) {
              return {'grafik bilgileri', 'grafik'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Furkan Aygün'),
      ),
    );
  }
}

class GrafikBilgileri extends StatefulWidget {
  const GrafikBilgileri({super.key});

  @override
  _GrafikBilgileriState createState() => _GrafikBilgileriState();
}

class _GrafikBilgileriState extends State<GrafikBilgileri> {
  final TextEditingController xController = TextEditingController();
  final TextEditingController yController = TextEditingController();
  final TextEditingController controllerSol = TextEditingController();
  final TextEditingController controllerAlt = TextEditingController();

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool validateInput(String input) {
    return RegExp(r'^[0-9\s]*$').hasMatch(input);
  }

  bool checkAndProcessInput(BuildContext context) {
    String xInput = xController.text.trim();
    String yInput = yController.text.trim();
//    print(xInput + 'asd' + yInput);
    if (!validateInput(xInput) || !validateInput(yInput)) {
      showAlertDialog(context, "Hata", "Girdiler geçerli değil.");
      return false;
    }

    List<String> xParts =
        xInput.split(' ').where((element) => element.isNotEmpty).toList();
    List<String> yParts =
        yInput.split(' ').where((element) => element.isNotEmpty).toList();

    // List<int> xIntParts = xParts.map((part) => int.parse(part)).toList();
    // List<int> yIntParts = yParts.map((part) => int.parse(part)).toList();

    if (xParts.length != yParts.length) {
      showAlertDialog(context, "Eşleşme Hatası",
          "X ve Y eksen girdilerindeki sayısal parça sayıları eşit değil.");
      return false;
    }

//    print("Girdiler geçerli ve eşleşiyor.");
    return true;
    // Burada girdilerle ilgili işlemleri gerçekleştirebilirsiniz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: xController,
              decoration: const InputDecoration(hintText: 'X eksen girdisi'),
            ),
            TextField(
              controller: yController,
              decoration: const InputDecoration(hintText: 'Y eksen girdisi'),
            ),
            TextField(
              controller: controllerSol,
              decoration: const InputDecoration(hintText: 'Grafik sol başlık'),
            ),
            TextField(
              controller: controllerAlt,
              decoration: const InputDecoration(hintText: 'Grafik alt başlık'),
            ),
            ElevatedButton(
              onPressed: () {
                if (checkAndProcessInput(context)) {
                  // Değerleri hesapla
                  List<String> xParts = xController.text
                      .trim()
                      .split(' ')
                      .where((element) => element.isNotEmpty)
                      .toList();
                  List<String> yParts = yController.text
                      .trim()
                      .split(' ')
                      .where((element) => element.isNotEmpty)
                      .toList();

                  List<int> xIntParts =
                      xParts.map((part) => int.parse(part)).toList();
                  List<int> yIntParts =
                      yParts.map((part) => int.parse(part)).toList();

                  String leftTitle = controllerSol.text;
                  String bottomTitle = controllerAlt.text;

                  // GrafikGoruntusu sayfasına yönlendir ve verileri gönder
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GrafikGoruntusu(
                        xValues: xIntParts,
                        yValues: yIntParts,
                        leftTitle: leftTitle,
                        bottomTitle: bottomTitle,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Çiz Butonu'),
            ),
          ],
        ),
      ),
    );
  }
}

class GrafikGoruntusu extends StatelessWidget {
  final List<int> xValues; // x eksenindeki değerler
  final List<int> yValues; // y eksenindeki değerler
  final String leftTitle; // Sol eksen başlığı
  final String bottomTitle; // Alt eksen başlığı

  const GrafikGoruntusu({
    Key? key,
    required this.xValues,
    required this.yValues,
    required this.leftTitle,
    required this.bottomTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Grafiğin oluşturulması için gereken spots listesi
    List<FlSpot> spots = List.generate(
      xValues.length,
      (index) => FlSpot(xValues[index].toDouble(), yValues[index].toDouble()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Grafik Container'ı
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Ekranın yarısı kadar yükseklik
              width: MediaQuery.of(context).size.width *
                  0.9, // Ekranın %90 genişliği
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                      show: true), // Başlıklar için SideTitles kullanmıyoruz
                ),
              ),
            ),
            // Sol başlık için Text widget'ı
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.25, // Grafik yüksekliğinin ortası
              left: 4,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(leftTitle,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            // Alt başlık için Text widget'ı
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width *
                  0.45, // Grafik genişliğinin ortası
              child: Text(bottomTitle,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
