import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:son_odev/json/map.dart';
import 'dart:io';

import '../json/db_helper.dart';
import '../json/employee.dart';

class NewEmployeePage extends StatefulWidget {
  @override
  _NewEmployeePageState createState() => _NewEmployeePageState();
}

class _NewEmployeePageState extends State<NewEmployeePage> {
  String name = ''; // Çalışan adı
  String tc = ''; // TC no
  String department = ''; // Departman
  double salary = 0; // Maaş
  String address = ''; // Adres
  double tecrube = 0; // Tecrübe (Slider için)
  File? _pickedImage; // Seçilen resim

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  // Etkinliği veritabanına kaydetme fonksiyonu
  // Çalışanı veritabanına kaydetme fonksiyonu
  void _saveEmployee(BuildContext context) async {
    // Yeni çalışan oluştur
    final newEmployee = Employee(
      name: name,
      tcNo: tc,
      department: department,
      salary: salary,
      address: address,
      imagePath: _pickedImage?.path ?? '',
      tecrube: tecrube, // Tecrübe bilgisini de ekleyin
    );

    // Çalışanı veritabanına ekle
    await DBHelper.insertEmployee(newEmployee);

    // İşlem tamamlandıktan sonra önceki ekrana dön
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Çalışan Ekle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // Resim ekleme butonu
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Resim Ekle'),
              ),
              SizedBox(height: 20),
              // Çalışan adı giriş alanı
              TextField(
                decoration: InputDecoration(labelText: 'Ad'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              // TC no giriş alanı
              TextField(
                decoration: InputDecoration(labelText: 'TC No'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Sadece sayısal girişi kabul et
                  LengthLimitingTextInputFormatter(
                      11), // Maksimum uzunluk 11 karakter
                ],
                onChanged: (value) {
                  if (value.length == 11) {
                    setState(() {
                      tc = value;
                    });
                  }
                },
              ),
              // Departman giriş alanı
              TextField(
                decoration: InputDecoration(labelText: 'Departman'),
                onChanged: (value) {
                  setState(() {
                    department = value;
                  });
                },
              ),
              // Maaş giriş alanı
              TextField(
                decoration: InputDecoration(labelText: 'Maaş'),
                onChanged: (value) {
                  setState(() {
                    salary = double.tryParse(value) ?? 0;
                  });
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLocationPage()),
                  );

                  if (result != null) {
                    setState(() {
                      address = "${result['city']} ${result['district']}";
                    });
                  }
                },
                child: Text('Haritadan Adres Seç'),
              ),

              SizedBox(
                height: 30,
              ),
              // Tecrübe slider'ı
              Text('Tecrübe: ${tecrube.round()} Yıl'),
              Slider(
                value: tecrube,
                min: 0,
                max: 30,
                divisions: 30,
                onChanged: (value) {
                  setState(() {
                    tecrube = value;
                  });
                },
              ),
              // Kayıt butonu
              ElevatedButton(
                onPressed:
                    tc.length == 11 ? () => _saveEmployee(context) : null,
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: tc.length == 11
                      ? Colors.blue
                      : Colors.grey, // Eğer TC no 11 karakter değilse gri renk
                ),
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
