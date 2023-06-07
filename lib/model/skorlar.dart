import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> dosyaYoluAl(String dosyaAdi) async {
  final dizin = await getApplicationDocumentsDirectory();
  return File('${dizin.path}/$dosyaAdi');
}

Future<List<int>> skorlariOku() async {
  final file = await dosyaYoluAl('skorlar.txt');

  try {
    final icerik = await file.readAsLines();
    return icerik.map(int.parse).toList();
  } catch (e) {
    return [];
  }
}

Future<void> skorEkle(int skor) async {
  final file = await dosyaYoluAl('skorlar.txt');

  try {
    final eskiSkorlar = await skorlariOku();
    final yeniSkorlar = [...eskiSkorlar, skor];

    final yazilacakMetin = yeniSkorlar.map((skor) => '$skor\n').join();
    await file.writeAsString(yazilacakMetin);
  } catch (e) {
    print('Skor eklenirken bir hata oluştu: $e');
  }
}

