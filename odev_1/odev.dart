// import 'dart:io';
// import 'dart:math';

// void odev1() {
//   int no = 6; // okul no
//   print("okul numarası $no");

//   String tersSayi =
//       no.toString().split('').reversed.join(); // Sayıyı tersine çevir
//   print("tersten yazılışı $tersSayi");
//   int aa = int.parse(tersSayi);
//   int enYakinAsal = bulEnYakinAsal(aa);
//   print('$tersSayi sayısına en yakın asal sayı: $enYakinAsal');

//   derece_hesapla();

//   soru3_4();

//   soru5();
// }

// int bulEnYakinAsal(int sayi) {
//   int i = sayi;
//   int asalBuyuk = sayi;
//   int asalKucuk = sayi;

//   while (true) {
//     if (asalMi(i)) {
//       asalBuyuk = i;
//       break;
//     }
//     i++;
//   }

//   i = sayi - 1;
//   while (i >= 2) {
//     if (asalMi(i)) {
//       asalKucuk = i;
//       break;
//     }
//     i--;
//   }

//   int sonuc = asalBuyuk - sayi <= sayi - asalKucuk ? asalBuyuk : asalKucuk;
//   for (i = 2; i <= sonuc; i++) {
//     if (asalMi(i)) {
//       print('Asal sayı: $i');
//     }
//   }
//   return sonuc;
// }

// bool asalMi(int sayi) {
//   if (sayi < 2) return false;
//   if (sayi < 4) return true;
//   if (sayi % 2 == 0) return false;

//   for (int i = 3; i * i <= sayi; i += 2) {
//     if (sayi % i == 0) {
//       return false;
//     }
//   }

//   return true;
// }

// derece_hesapla() {
//   stdout.write("Celsius sıcaklık değerini girin: ");
//   String input = stdin.readLineSync() ?? "";
//   double celsius = double.tryParse(input) ?? 0.0;

//   double kelvin = celsius + 273.15;
//   double fahrenheit = (celsius * 9 / 5) + 32;

//   print(
//       '$celsius Celsius, $kelvin Kelvin ve $fahrenheit Fahrenheit\'a eşittir.');
// }

// void soru3_4() {
//   stdout.write("Kaç adet sayı gireceksiniz: ");
//   String input = stdin.readLineSync() ?? "0";
//   int adet = int.tryParse(input) ?? 0;

//   List<double> sayilar = [];

//   for (int i = 0; i < adet; i++) {
//     stdout.write("Sayı $i: ");
//     String sayiInput = stdin.readLineSync() ?? "0";
//     double sayi = double.tryParse(sayiInput) ?? 0.0;
//     sayilar.add(sayi);
//   }

//   double standartSapma = hesaplaStandartSapma(sayilar);
//   double enBuyukSayi = bulEnBuyukSayi(sayilar);

//   print('Girilen sayıların standart sapması: $standartSapma');
//   print('Girilen sayıların en büyüğü: $enBuyukSayi');
// }

// double hesaplaStandartSapma(List<double> sayilar) {
//   double toplam = 0;
//   double ortalama = 0;
//   double toplamKareFark = 0;

//   if (sayilar.isEmpty) {
//     return 0.0;
//   }

//   for (var sayi in sayilar) {
//     toplam += sayi;
//   }

//   ortalama = toplam / sayilar.length;

//   for (var sayi in sayilar) {
//     toplamKareFark += pow(sayi - ortalama, 2);
//   }

//   double standartSapma = sqrt(toplamKareFark / sayilar.length);
//   return standartSapma;
// }

// double bulEnBuyukSayi(List<double> sayilar) {
//   if (sayilar.isEmpty) {
//     print("liste boş en büyük sayı yok");
//     return 0.0;
//   }

//   double enBuyuk = sayilar[0];
//   for (var sayi in sayilar) {
//     if (sayi > enBuyuk) {
//       enBuyuk = sayi;
//     }
//   }
//   return enBuyuk;
// }

// soru5() {
//   List<int> sayilar = [1000, 10000, 100000, 1000000];
//   for (int sayi in sayilar) {
//     int asalSayilar = asalSayiAdedi(sayi);
//     double sonuc = asalSayilar.toDouble() / sayi;
//     print('Sayı: $sayi');
//     print('Asal Sayı Adedi: $asalSayilar');
//     print('Sonuç (kendisine bölünmüş): $sonuc\n');
//   }
// }

// int asalSayiAdedi(int sinir) {
//   int asalSayilar = 0;
//   for (int i = 2; i <= sinir; i++) {
//     if (asalMi(i)) {
//       asalSayilar++;
//     }
//   }
//   return asalSayilar;
// }



// // Soru 1: Öğrenci numaranızı tersten ekrana yazdırın. Daha sonra ortaya çıkan 
// // bu sayıya en yakın asal sayıyı bulan kodu yazınız.
// // Bu sayıya kadar olan asal sayılar ekrana yazdırılmalı. 
// // Not: Eğer öğrenci numaranızın tersten yazılmış haline en yakın asal sayı 
// // bu sayıdan büyükse döngü oraya kadar gitmeli. 

// // Soru 2: Verilen Celcius sıcaklık derecesini, 
// // Kelvin ve Fahreneit’a çeviren kodu yazınız.

// // Soru 3: Kullanıcı tarafından belirlenecek adet kadar verilen 
// // sayı dizisi/listesinde standart sapmayı hesaplayan kodu yazınız.

// // Soru 4: Kullanıcı tarafından belirlenecek adet kadar verilen sayı dizisindeki
// // en büyük sayıyı bulan kodu yazınız. 

// // Not: 3 ve 4. Soru bağlantılı olarak aynı kodun içinde yapılabilir. 
// // Bu soruları çözerken kullanıcı tarafından 
// // girilen sayı dizisini ekrana yazdırın.

// // Soru 5: 1000 sayısına kadar olan asal sayıların sayısını bulun 
// // ve çıkan sonucu 1000’e bölün. 
// // Daha sonra bu işlemi 10 bin, 100 bin ve 1 milyon sayıları için yapın. 
// // Ekrana çıkan sonuçları yazdırın. Bu sorunun amacı; 
// // sayılar büyüdükçe asal sayıların bulunma oranının
// // nasıl azaldığını gözlemlemektir. Dilerseniz bu deneyi 10 milyon, 
// // 100 milyon şeklinde uzatabilirsiniz.