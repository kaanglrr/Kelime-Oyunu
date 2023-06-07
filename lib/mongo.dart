import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

Future<void> ekleBelge(int puan) async {
    final db = await Db.create('mongoid');
    await db.open();
    final collection = db.collection('skorlar');
    await collection.insert({
      'puan': puan
    });
    await db.close();
  }

Future<List> getPuanlar() async {
  final db = await Db.create('mongoid');
  await db.open();
  final collection = db.collection('skorlar');
  final results = await collection.find().map((doc) => doc['puan']).toList();
  await db.close();
  results.sort();
  return results;
}


