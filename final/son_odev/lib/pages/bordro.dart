import 'dart:io';

import 'package:flutter/material.dart';
import 'package:son_odev/json/db_helper.dart';
// Gerekli diğer importlar (veritabanı sorgusu için)

class EmployeeSearchPage extends StatefulWidget {
  @override
  _EmployeeSearchPageState createState() => _EmployeeSearchPageState();
}

class _EmployeeSearchPageState extends State<EmployeeSearchPage> {
  String tcNo = '';
  String employeeImagePath = '';
  double employeeSalary = 0.0;
  bool isLoading = false;

  // Future<void> fetchEmployeeData() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   // Veritabanı sorgusu yapılacak yer
  //   // Örnek: var employeeData = await DatabaseHelper.getEmployeeData(tcNo);
  //   // employeeImagePath = employeeData.imagePath;
  //   // employeeSalary = employeeData.salary;

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  // Future<void> fetchEmployeeData() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     var employeeData = await DBHelper.getEmployeeData(tcNo);
  //     if (employeeData != null) {
  //       setState(() {
  //         employeeImagePath = employeeData.imagePath;
  //         employeeSalary = employeeData.salary;
  //       });
  //     } else {
  //       // Eşleşen çalışan bulunamadıysa
  //       print('Çalışan bulunamadı');
  //     }
  //   } catch (e) {
  //     // Hata işleme
  //     print('Veritabanı sorgusunda hata oluştu: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  List<SalaryPayment> salaryPayments = [];

  Future<void> fetchEmployeeData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var employeeData = await DBHelper.getEmployeeData(tcNo);
      if (employeeData != null) {
        var payments = await DBHelper.getSalaryPayments(employeeData.id);
        setState(() {
          employeeImagePath = employeeData.imagePath;
          employeeSalary = employeeData.salary;
          salaryPayments = payments;
        });
      } else {
        // Eşleşen çalışan bulunamadıysa
        print('Çalışan bulunamadı');
      }
    } catch (e) {
      // Hata işleme
      print('Veritabanı sorgusunda hata oluştu: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çalışan Sorgula'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'TC No'),
              onChanged: (value) {
                tcNo = value;
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: fetchEmployeeData,
          //   child: Text('Sorgula'),
          // ),
          // isLoading
          //     ? CircularProgressIndicator()
          //     : Column(
          //         children: <Widget>[
          //           if (employeeImagePath.isNotEmpty)
          //             Image.network(employeeImagePath),
          //           Text('Maaş: ${employeeSalary.toString()} TL'),
          //         ],
          //       ),
          ElevatedButton(
            onPressed: fetchEmployeeData,
            child: Text('Sorgula'),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: Column(
                    children: <Widget>[
                      if (employeeImagePath.isNotEmpty)
                        InteractiveViewer(
                          panEnabled: true, // Pan hareketini etkinleştirir
                          boundaryMargin: EdgeInsets.all(80), // Sınır boşluğu
                          minScale: 0.5, // Minimum zoom oranı
                          maxScale: 4, // Maksimum zoom oranı
                          child: Image.file(File(employeeImagePath)),
                        ),

                      // if (employeeImagePath.isNotEmpty)
                      //   Image.file(File(employeeImagePath)),
                      Text('Maaş: ${employeeSalary.toString()} TL'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: salaryPayments.length,
                          itemBuilder: (context, index) {
                            // Her bir maaş ödemesi için bir ListTile oluşturun
                            return ListTile(
                              title: Text(
                                  '${salaryPayments[index].paymentDate.toLocal()}'),
                              subtitle: Text(
                                  'Miktar: ${salaryPayments[index].amount.toString()} TL'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
