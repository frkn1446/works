import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:son_odev/json/db_helper.dart';

class SalaryDepositPage extends StatefulWidget {
  @override
  _SalaryDepositPageState createState() => _SalaryDepositPageState();
}

class _SalaryDepositPageState extends State<SalaryDepositPage> {
  String selectedNumber = '0'; // Varsayılan olarak '0' seçili
  final List<String> numbers = List.generate(10, (index) => index.toString());
  final TextEditingController amountController = TextEditingController();

  Future<void> depositSalary() async {
    final amount = double.tryParse(amountController.text) ?? 0;
    if (amount > 0) {
      final result = await DBHelper.depositSalary(selectedNumber, amount);
      int normalCount = result['normalCount'] ?? 0;
      int increasedCount = result['increasedCount'] ?? 0;
      // Pop-up mesajı göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Maaş Yatırma İşlemi Tamamlandı'),
            content: Text(
                'Seçilen numara: $selectedNumber\nYatırılan toplam miktar: $amount TL\n'
                'Normal Fiyatla Maaş Yatırılan Çalışan Sayısı: $normalCount\n'
                'Zamlı Fiyatla Maaş Yatırılan Çalışan Sayısı: $increasedCount'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Hatalı miktar girişi için uyarı
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Geçersiz miktar.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maaş Yatır'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              value: selectedNumber,
              onChanged: (String? newValue) {
                setState(() {
                  selectedNumber = newValue!;
                });
              },
              items: numbers.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Miktar',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: depositSalary,
              child: Text('Maaş Yatır'),
            ),
          ],
        ),
      ),
    );
  }
}
