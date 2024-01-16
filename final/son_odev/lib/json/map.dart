import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'city.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  LatLng? selectedLocation;
  void _onRegisterButtonPressed() {
    if (selectedLocation != null) {
      getCityAndDistrict(
              selectedLocation!.latitude, selectedLocation!.longitude)
          .then((result) {
        String city = result['city'] ?? '';
        String district = result['district'] ?? '';

        // Burada şehir ve ilçe bilgilerini önceki sayfaya döndürüyoruz
        Navigator.pop(context, {'city': city, 'district': district});
      }).catchError((e) {
        print('Hata: $e');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lütfen bir nokta seçin"),
        ),
      );
    }
  }

  Future<void> _onTap(LatLng location) async {
    setState(() {
      selectedLocation = location;
    });

    // Seçilen konumun şehir ve ilçe bilgilerini al
    final locationInfo =
        await getCityAndDistrict(location.latitude, location.longitude);
    print("Şehir: ${locationInfo['city']}, İlçe: ${locationInfo['district']}");

    // Seçilen konumu geri döndür
    // Navigator.pop(context, selectedLocation);
    Navigator.pop(context, {
      'location': selectedLocation,
      'city': locationInfo['city'],
      'district': locationInfo['district']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 70, 70),
        elevation: 0,
        title: Text(
          "Konum Seç",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed:
                    _onRegisterButtonPressed, // Yeni fonksiyonu burada çağır
                icon: Icon(
                  Icons.app_registration_sharp,
                  size: 27,
                ),
              );
            },
          ),
        ],
      ),
//        title: Text('Konum Seç'),

      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(39.9334,
              32.8597), // İlk açılışta gösterilecek konum (Örnek: Ankara)
          zoom: 14.0,
        ),
        markers: Set<Marker>.from(
          [
            if (selectedLocation != null)
              Marker(
                markerId: MarkerId('selected_point'),
                position: selectedLocation!,
                draggable: false,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
          ],
        ),
        onTap: (LatLng point) {
          setState(
            () {
              selectedLocation = point;
            },
          );
        },
      ),
    );
  }
}
