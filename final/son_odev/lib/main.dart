import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home:
        HomePage(), // Burada HomePage direkt olarak anasayfa olarak ayarlanıyor
  ));
}
