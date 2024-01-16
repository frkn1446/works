import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'employee.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'employees.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, tcNo TEXT, department TEXT, salary REAL, address TEXT, imagePath TEXT,tecrube REAL)',
        );
        db.execute(
          'CREATE TABLE salary_payments(id INTEGER PRIMARY KEY AUTOINCREMENT, employeeId INTEGER, paymentDate TEXT, amount REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertEmployee(Employee employee) async {
    final db = await DBHelper.getDatabase();
    await db.insert('employees', employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Employee>> getEmployees() async {
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) {
      return Employee(
        id: maps[i]['id'],
        name: maps[i]['name'],
        tcNo: maps[i]['tcNo'],
        department: maps[i]['department'],
        salary: maps[i]['salary'],
        address: maps[i]['address'],
        imagePath: maps[i]['imagePath'],
        tecrube: maps[i]['tecrube'] != null
            ? double.tryParse(maps[i]['tecrube'].toString()) ?? 0.0
            : 0.0, // Tecrübe bilgisini ekleyin
      );
    });
  }

  static Future<void> deleteEmployee(int id) async {
    final db = await DBHelper.getDatabase();
    await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAllEmployees() async {
    final db = await DBHelper.getDatabase();
    await db.delete('employees');
  }

  static Future<Employee?> getEmployeeData(String tcNo) async {
    final db = await DBHelper.getDatabase();
    final maps = await db.query(
      'employees',
      where: 'tcNo = ?',
      whereArgs: [tcNo],
    );

    if (maps.isNotEmpty) {
      return Employee.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<SalaryPayment>> getSalaryPayments(int? employeeId) async {
    if (employeeId == null) {
      return [];
    }

    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'salary_payments',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
    );

    return List.generate(maps.length, (i) {
      return SalaryPayment(
        employeeId: maps[i]['employeeId'],
        paymentDate: DateTime.parse(maps[i]['paymentDate']),
        amount: maps[i]['amount'],
      );
    });
  }

  static Future<Map<String, int>> depositSalary(
      String tcNoEndsWith, double amount) async {
    int normalCount = 0;
    int increasedCount = 0;

    final db = await DBHelper.getDatabase();
    // TC numarasının sonu belirtilen rakamla biten çalışanları bul
    final employees = await db.query(
      'employees',
      where: 'tcNo LIKE ?',
      whereArgs: ['%$tcNoEndsWith'],
    );

    // Her bir çalışan için maaş yatırma işlemi yap
    for (var employeeMap in employees) {
      double finalAmount = amount;
      Employee employee = Employee.fromMap(employeeMap);
      // Tecrübeye göre maaş miktarını ayarla
      if (employee.tecrube >= 10 && employee.tecrube < 20) {
        finalAmount *= 1.15; // %15 fazla
      } else if (employee.tecrube >= 20) {
        finalAmount *= 1.25; // %25 fazla
      }
      if (employee.tecrube >= 10) {
        increasedCount++;
      } else {
        normalCount++;
      }
      // Maaş yatırma işlemini veritabanına kaydet
      await db.insert('salary_payments', {
        'employeeId': employee.id,
        'paymentDate': DateTime.now().toIso8601String(),
        'amount': finalAmount,
      });
    }
    return {'normalCount': normalCount, 'increasedCount': increasedCount};
  }
}

class SalaryPayment {
  final int employeeId;
  final DateTime paymentDate;
  final double amount;

  SalaryPayment({
    required this.employeeId,
    required this.paymentDate,
    required this.amount,
  });
}
