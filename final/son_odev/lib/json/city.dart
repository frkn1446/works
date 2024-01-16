import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<Map<String, String>> getCityAndDistrict(
//     double latitude, double longitude) async {
//   String API_KEY = 'AIzaSyBwJB3UPLqDWQD5rJfK255pDrJLZCuAk1s';
//   print("sadasdas");
//   final url =
//       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY';

//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['status'] == 'OK') {
//         final results = data['results'] as List<dynamic>;
//         if (results.isNotEmpty) {
//             String city = '';
//           String district = '';
//           // Adres bileşenlerini çözümlemek için döngü
//           for (var component in results[0]['address_components']) {
//             var types = component['types'];
//             if (types.contains('locality')) {
//               // Şehir bilgisi
//               String city = component['long_name'];
//               // İlçe bilgisi
//               String district =
//                   results[0]['address_components'][2]['long_name'];
//               return {'city': city, 'district': district};
//             }
//           }
//         }
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
//   return {'city': '', 'district': ''};
// }

Future<Map<String, String>> getCityAndDistrict(
    double latitude, double longitude) async {
  String API_KEY = '';
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final results = data['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          String city = '';
          String district = '';
          // Adres bileşenlerini çözümlemek için döngü
          for (var component in results[0]['address_components']) {
            var types = component['types'];
            if (types.contains('locality')) {
              // Şehir bilgisi
              city = component['long_name'];
            }
            if (types.contains('administrative_area_level_2')) {
              // İlçe bilgisi
              district = component['long_name'];
            }
          }
          // Eğer 'locality' tipinde şehir bulunamazsa, 'administrative_area_level_1' tipini kontrol edin
          if (city.isEmpty) {
            for (var component in results[0]['address_components']) {
              var types = component['types'];
              if (types.contains('administrative_area_level_1')) {
                city = component['long_name'];
                break; // Şehir bilgisi bulunduğunda döngüden çık
              }
            }
          }
          return {'city': city, 'district': district};
        }
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return {'city': '', 'district': ''};
}
