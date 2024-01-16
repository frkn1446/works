import 'package:final_odev_1/class_DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'class Event.dart';

class NewEventPage extends StatefulWidget {
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  double attendees = 50; // Kişi sayısı için başlangıç değeri
  String eventName = ''; // Etkinlik adı
  DateTime selectedDate =
      DateTime.now(); // Etkinlik tarihi için başlangıç değeri

  // Etkinlik tarihini seçmek için DateTime Picker fonksiyonu
  File? _pickedImage;
  Event event = Event(
    // Başlangıç değerleriyle Event nesnesini oluşturun
    title: '',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    attendees: 0,
    imagePath: '',
    sliderValue: 0.0,
  );

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Etkinliği veritabanına kaydetme fonksiyonu
  void _saveEvent(BuildContext context) async {
    // Yeni etkinlik oluştur
    final newEvent = Event(
      title: eventName,
      startDate: selectedDate,
      endDate:
          selectedDate, // Varsayılan olarak aynı gün olarak ayarlanmıştır. İhtiyaca göre değiştirilebilir.
      attendees: attendees.toInt(),
      imagePath: _pickedImage?.path ?? '', // Resim seçilmediyse boş string
    );

    // Etkinliği veritabanına ekle
    await DBHelper.insertEvent(newEvent);

    // İşlem tamamlandıktan sonra önceki ekrana dön
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Yeni Etkinlik Ekle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('Kişi Sayısı: ${attendees.round()}'),
              Slider(
                value: attendees,
                min: 0,
                max: 1000,
                divisions: 1000,
                onChanged: (value) {
                  setState(() {
                    attendees =
                        value; // Slider değerini int'e çevirip attendees'e atıyoruz
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Etkinlik Adı'),
                onChanged: (value) {
                  setState(() {
                    eventName = value;
                  });
                },
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Etkinlik Tarihi Seçin'),
                ),
              ),
              SizedBox(height: 20),
              // Resim yükleme alanı eklenecek...
              // Buton ekleme...
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Resim Ekle'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveEvent(context),
                child: Text('Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
