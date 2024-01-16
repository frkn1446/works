import 'package:final_odev_1/class_DBHelper.dart';
import 'package:final_odev_1/class_NewEventPage.dart';
import 'package:final_odev_1/event_card.dart';
import 'package:flutter/material.dart';

import 'class Event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planlayıcı Final Odev 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Event> events = [];

  void deleteSelectedEvents() async {
    print('Silme işlemi başladı.');
    List<Event> selectedEvents = events
        .where((event) =>
            event.isSelected && event.endDate.isBefore(DateTime.now()))
        .toList();

    for (var event in selectedEvents) {
      if (event.id != null) {
        print('Silinecek etkinlik ID: ${event.id}');
        await DBHelper.deleteEvent(event.id!);
      }
    }

    // Veritabanındaki güncel verileri yükle
    var updatedEvents = await DBHelper.getEvents();
    setState(() {
      events = updatedEvents;
    });
    print('Silme işlemi tamamlandı ve etkinlikler yeniden yükleniyor.');
  }

  @override
  void initState() {
    super.initState();
    _loadEvents();
//    testDbHelper();
  }

  Future<void> _loadEvents() async {
    List<Event> loadedEvents = await DBHelper.getEvents();
    setState(() {
      events = loadedEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listeyi kontrol ediyoruz, eğer boşsa bir widget gösteriyoruz.
    if (events.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Final Odev 1 Planlayıcı"),
        ),
        body: const Center(
          child: Text('Henüz etkinlik yok.'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewEventPage()),
            ).then((_) {
              // Etkinlik ekleme ekranından dönüldüğünde verileri yeniden yükle
              _loadEvents();
            });
          },
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: deleteSelectedEvents,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Final Odev 1 Planlayıcı"),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, i) {
          // Adı olmayan etkinlikleri atla
          if (events[i].title.isEmpty) {
            return Container(); // Boş bir widget döndür
          }
          return EventCard(
            event: events[i],
            onCheckboxChanged: (bool? newValue) {
              setState(() {
                events[i].isSelected = newValue ?? false;
              });
            },
            onSliderChanged: (double value) {
              // Slider değişikliği işlemleri, örneğin:
              // Bu örnek yalnızca okuma amaçlıdır ve çalışmayabilir çünkü EventCard stateless bir widget'tır.
              setState(() {
                events[i].sliderValue = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewEventPage()),
          ).then((_) {
            // Etkinlik ekleme ekranından dönüldüğünde verileri yeniden yükle
            _loadEvents();
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteSelectedEvents,
            ),
            // Diğer butonlarınız veya widget'larınız buraya eklenebilir.
            ElevatedButton(
              onPressed: () async {
                await DBHelper.deleteAllEvents();
                print('Veritabanı temizlendi.');

                // Veritabanından verileri yeniden yükle
                List<Event> updatedEvents = await DBHelper.getEvents();

                // UI'ı güncellemek için setState kullan
                setState(() {
                  events = updatedEvents; // 'events' listesini güncelle
                });
              },
              child: Text('Veritabanını Temizle'),
            )
          ],
        ),
      ),
    );
  }
}
