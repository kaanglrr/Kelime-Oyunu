import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
/*
class MongoDatabase{
  static var db, collection;
  static connect() async {
    db = await Db.create("mongodb+srv://yazlabbb45:9uIuJf3puFqpvVUs@yazlab2.tpj9lta.mongodb.net/?retryWrites=true&w=majority");
    
    await db.open();
    inspect(db);
    collection = db.collection("skorlar");
    
  }
    
  static Future<List> getSkor() async {
    final data = await collection.find().map((doc) => doc['puan']).toList();
    await db.close();
    return data;
  }

  static Future<void> addSkor(int puan) async {
    await collection.insertOne({
      "puan": puan
    });
  }

  
}
*/

Future<void> ekleBelge(int puan) async {
    final db = await Db.create('mongodb+srv://yazlabbb45:9uIuJf3puFqpvVUs@yazlab2.tpj9lta.mongodb.net/?retryWrites=true&w=majority');
    await db.open();
    final collection = db.collection('skorlar');
    await collection.insert({
      'puan': puan
    });
    await db.close();
  }

Future<List> getPuanlar() async {
  final db = await Db.create('mongodb+srv://yazlabbb45:9uIuJf3puFqpvVUs@yazlab2.tpj9lta.mongodb.net/?retryWrites=true&w=majority');
  await db.open();
  final collection = db.collection('skorlar');
  final results = await collection.find().map((doc) => doc['puan']).toList();
  await db.close();
  results.sort();
  return results;
}


