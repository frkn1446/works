import 'package:flutter/material.dart';
import '../json/db_helper.dart';
import 'bordro.dart';
import 'calisan_ekle.dart';
import 'maas.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  void _viewAllEmployees() async {
    // Tüm çalışanları veritabanından al
    final employees = await DBHelper.getEmployees();
    // Konsola çalışan bilgilerini yazdır
    print("tüm çalışanlar\n\n\n\n");
    for (var employee in employees) {
      print('ID: ${employee.id}, İsim: ${employee.name}, TC: ${employee.tcNo}, '
          'Departman: ${employee.department}, Maaş: ${employee.salary}, Adres: ${employee.address}, '
          'Resim Yolu: ${employee.imagePath}, Tectube: ${employee.tecrube}');
    }
  }

  void _deleteAllEmployees() async {
    // Tüm verileri veritabanından sil
    await DBHelper.deleteAllEmployees();
    // Kullanıcıya işlemin tamamlandığını bildir
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tüm veriler silindi.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onSelect(String page) {
    switch (page) {
      case 'Çalışan Ekle':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewEmployeePage()),
        );
        break;
      case 'Çalışan Görüntüle':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmployeeSearchPage()),
        );
        break;
      case 'Maaş Öde':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalaryDepositPage()),
        );
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _onSelect,
            itemBuilder: (BuildContext context) {
              return {'Çalışan Ekle', 'Çalışan Maaş Bordrosu', 'Maaş Öde'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEmployeePage()),
                );
              },
              child: Text('Çalışan Ekle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeSearchPage()),
                );
              },
              child: Text('Çalışan Maaş Bordrosu'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalaryDepositPage()),
                );
              },
              child: Text('Maaş Öde'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _viewAllEmployees,
              child: Text('Tüm Çalışanları Görüntüle'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteAllEmployees,
              child: Text('Tüm Verileri Sil'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Butonun rengini belirleyin
              ),
            ),
          ],
        ),
      ),
    );
  }
}
