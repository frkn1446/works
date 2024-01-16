//import 'package:final_odev_1/event_card.dart';
//import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
//import 'package:image_picker/image_picker.dart';
//import 'dart:io';
//import 'package:intl/intl.dart';

import 'class Event.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'events.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, start_date TEXT, end_date TEXT, attendees INTEGER, imagePath TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertEvent(Event event) async {
    final db = await DBHelper.getDatabase();
    await db.insert('events', event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Event>> getEvents() async {
    final db = await DBHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) {
      return Event(
          id: maps[i]['id'],
          title: maps[i]['title'],
          startDate: DateTime.parse(maps[i]['start_date']),
          endDate: DateTime.parse(maps[i]['end_date']),
          attendees: maps[i]['attendees'],
          imagePath: maps[i]['imagePath']);
    });
  }

  static Future<void> deleteEvent(int id) async {
    final db = await DBHelper.getDatabase();
    print('Veritabanından siliniyor: $id');
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAllEvents() async {
    final db = await DBHelper.getDatabase();
    await db.delete('events'); // 'events' tablosundaki tüm kayıtları sil
  }
}
