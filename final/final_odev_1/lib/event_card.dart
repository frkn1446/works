import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
//import 'package:path/path.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'class Event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final ValueChanged<bool?> onCheckboxChanged;

  final ValueChanged<double> onSliderChanged; // Bu satırı ekleyin

  EventCard({
    Key? key,
    required this.event,
    required this.onCheckboxChanged,
    required this.onSliderChanged, // Bu parametreyi constructor'a ekleyin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysLeft = event.endDate.difference(now).inDays;
    double sliderValue;

    if (daysLeft >= 100) {
      // Eğer bitiş tarihine 100 gün veya daha fazla varsa, slider değeri 0 olacak
      sliderValue = 0.0;
    } else {
      // Eğer bitiş tarihine 100 günden az kaldıysa, slider değeri kalan gün sayısına göre ayarlanacak
      sliderValue = 100.0 - daysLeft;
    }

    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: event.imagePath.isNotEmpty
                    ? FileImage(File(event.imagePath))
                    : null,
                child: event.imagePath.isEmpty ? Text(event.title[0]) : null,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(event.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(DateFormat('yyyy-MM-dd').format(event.startDate)),
                  ],
                ),
              ),
              Text('${event.attendees} KS', style: TextStyle(fontSize: 16)),
              Checkbox(
                value: event.isSelected,
                onChanged: onCheckboxChanged,
              ),
            ],
          ),
//           Slider(
// //            value: event.sliderValue, // 'event' burada kullanılıyor
//             value:
//                 sliderValue.clamp(0.0, 1.0), // Değeri 0 ile 1 arasında sınırla

//             min: 0,
//             max: 1000,
//             divisions: 1000,
//             onChanged: null, // Slider değişiklikleri için callback kullanın
//           ),
          // Slider(
          //   value: sliderValue, // Hesaplanan slider değeri
          //   min: 0.0, // Minimum değer
          //   max: 1000.0, // Maksimum değer
          //   divisions: 1000, // Bölüm sayısı
          //   onChanged: null, // Slider etkileşimli olmayacak
          // ),
          Slider(
            value: sliderValue,
            min: 0.0, // Minimum değer
            max: 110.0, // Maksimum değer
            divisions: 100, // Bölüm sayısı
            onChanged: null, // Slider etkileşimli olmayacak
          ),
        ],
      ),
    );
  }
}
