
import 'package:flutter/material.dart';
import 'package:yazlab_2_2/mongo.dart';
import 'package:yazlab_2_2/screen/game.dart';

class SkorEkran extends StatefulWidget {
  @override
  _SkorEkranState createState() => _SkorEkranState();
}

class _SkorEkranState extends State<SkorEkran> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 71, 71, 71),
      body: FutureBuilder<List>(
        future: getPuanlar(),
        builder:
            (context, snapshot) {
          if (snapshot.hasData) {
            List documents = snapshot.data!;
            return Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  'En Yüksek Skorlar',
                  style: TextStyle(fontSize: 24.0,color: Colors.white),
                  
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                        return Center(
                          child: SizedBox(
                            height: 100,
                            width: 300,
                            child: Card(
                              color: Color.fromARGB(255, 121, 119, 118),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Center(
                                  child: Text("${documents[documents.length-index-1]}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white)
                                          ),
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(),
                      ),
                    );
                  },
                  child: Text('Tekrar Oyna', style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  ),
                ),
                SizedBox(height: 50),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Hata oluştu: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}