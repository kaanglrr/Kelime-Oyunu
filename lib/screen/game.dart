import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yazlab_2_2/main.dart';
import 'package:yazlab_2_2/model/puan.dart';
import 'package:yazlab_2_2/model/skorlar.dart';
import 'package:yazlab_2_2/mongo.dart';
import 'package:yazlab_2_2/screen/skorEkran.dart';
import 'package:yazlab_2_2/wordAlgo.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
  
}

class _GameState extends State<Game> {

  List<bool> selectedList = List.filled(80, false);
  List<String> letters = List.filled(80, "");
  List<int> selectedIndexes = [];
  String selectedString = "";
  int levelSpeed = 5;
  int counter = 0;
  Timer? timer;
  int falseCounter = 0;
  int endListener = 0;
  int puan = 0;
  var kelimeListesi;
  
  loadWords() async {
    var dosya = await rootBundle.loadString('assets/kelimeler.txt');
    kelimeListesi = dosya.split(RegExp(r'\r?\n'));
  }

  void select(int index) {
    setState(() {
      
      selectedList[index] = !selectedList[index];
      if (!selectedList[index]) {
        selectedIndexes.remove(index);
      }else{
        selectedIndexes.add(index);
      }
      
    });
    setSelectedString();
  }

  void setSelectedString(){
    String temp = "";
    for (var i = 0; i < selectedIndexes.length; i++) {
      temp = temp + letters.elementAt(selectedIndexes.elementAt(i));
    }
    setState(() {
      selectedString = temp;
    });
  }

  void startCounter() {
    //timer = Timer.periodic(Duration(seconds: 1), (timer) { setState(() {
      Timer.periodic(Duration(seconds: 1), (timer) { setState(() {
      if (endListener == 1) {
        timer.cancel();
        showAlertDialog(context);
      }
      counter++;
      int speed = 5;
      if (puan>100 && puan<200) {
        speed = 4;
      }
      if (puan>200 && puan<300) {
        speed = 3;
      }
      if (puan>300 && puan<400) {
        speed = 2;
      }if (puan>=400) {
        speed = 1;
      }
      if(counter%speed == 0 && falseCounter != 3){
        singleLetterFlow();
      }
      if (falseCounter == 3) {
        singleRowFlow();
        setState(() {
          falseCounter = 0;
          counter = 0;
        });
      }
    }); });
  }

  @override
  void initState() {
    loadWords();
    threeRowFlow();
    super.initState();
  }
  void removeSelected() {
    setState(() {
      selectedList.fillRange(0, 80, false);
      selectedIndexes.clear();
      selectedString = "";
    });
  }

  void puanHesapla() {
    setState(() {
      puan = puan + kelimePuanHesapla(selectedString);
    });
  }

  void singleRowFlow() {
    int columnCount = 8;
    int rowCount = 10;
    List<String> generatedLetters = List.filled(8, "");

    for (var i = 0; i < columnCount; i++) {
      generatedLetters[i] = randomHarf();
    }

    int index = 0;
    Timer.periodic(Duration(milliseconds: 250), (timer) {
        if (index == 0) {
          for (var i = 0; i < columnCount; i++) {
            if(letters.elementAt((index*columnCount)+i) == ""){
              setState(() {
                letters[(index*columnCount)+i] = generatedLetters.elementAt(i);
              });
            }else{
              endListener = 1;
              timer.cancel();
            }
          }
        } else {
          for (var i = 0; i < columnCount; i++) {
            if( letters.elementAt((index*columnCount)+i) == ""){
              setState(() {
                letters[(index*columnCount)+i] = generatedLetters.elementAt(i);
                letters[((index-1)*columnCount)+i] = "";
              });
            }
          }
        }
      index++;
      if (index >= rowCount) {
        timer.cancel();
      }
    });
  }
  void threeRowFlow () {
    int columnCount = 8;
    int rowCount = 10;
    List<String> generatedLetters = List.filled(24, "");

    for (var i = 0; i < 3*columnCount; i++) {
      generatedLetters[i] = randomHarf();
    }

    int index = 0;
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      
      if (index == 0) {
        setState(() {
          letters.setAll(index*columnCount, generatedLetters);
        });
      }
      if (index != 0) {
        setState(() {
          letters.setRange((index-1)*columnCount, index*columnCount,["","","","","","","","",]);
          letters.setAll(index*columnCount, generatedLetters);
        });
      }

      index++;
      if (index >= rowCount-2) {
        timer.cancel();
        startCounter();
      }
    });
  }

  void singleLetterFlow() {
  int column = 8;
  int row = 10;
  int random = Random().nextInt(8);
  List<String> generatedLetters = List.filled(8, "");
  //generatedLetters[random] = String.fromCharCode(Random().nextInt(26) + 65);
  generatedLetters[random] = randomHarf();
  int index = 0;

  if (letters.elementAt((index*column)+random) == ""){
    Timer.periodic(Duration(milliseconds: 250), (timer) {
        if (index == 0) {
          if(letters.elementAt((index*column)+random) == ""){
            setState(() {
              letters[(index*column)+random] = generatedLetters.elementAt(random);
            });
          }
        } else {
            if( letters.elementAt((index*column)+random) == ""){
              setState(() {
                letters[(index*column)+random] = generatedLetters.elementAt(random);
                letters[((index-1)*column)+random] = "";
              });
            }
          }
        index++;
        if (index >= row) {
          timer.cancel();
        }
      });
    }else {
      setState(() {
              endListener = 1;
            });
    }
  }

  void acceptedFlow(List<int> trueWordIndexes) {
    int column = 8;
    int row = 10;
    int index = 0;
    String tempString = "";

    for (var i = 0; i < trueWordIndexes.length; i++) {
      setState(() {
        letters[trueWordIndexes[i]] = "";
      });
      index = trueWordIndexes[i] % 8;
      for (var j = row-1; j >0; j--) {
        if(letters.elementAt((j*column)+index) == ""){
          setState(() {
            letters[(j*column)+index] = letters.elementAt((j*column)+index-8);
            letters[(j*column)+index-8] = "";
          });
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // diyalog içeriği
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 200,
          height: 200,
          child: AlertDialog(
            backgroundColor: Colors.grey[300],
            actions: [
              Text("puan = $puan"),
              SizedBox(width: 16),
              ElevatedButton(
                child: Text('Tamam'),
                onPressed: () async {
                  await ekleBelge(puan);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SkorEkran()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSwiped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 99, 97, 97),
      body: Column(
        children: [
          SizedBox(height: 60),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple,
            ),
            child: Center(
              child: Text("$puan",style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1.0,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1
              ),
              padding: EdgeInsets.all(4),
              
              itemCount: 80,
              itemBuilder: (BuildContext context, int index) {
      
                return GestureDetector(
                  onTap: () {
                    if(letters.elementAt(index) != ""){
                      select(index);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: letters.elementAt(index) != "" && selectedList[index]? Colors.purple: letters.elementAt(index) != ""? Colors.blue: null),
                    child: Center(child: Text(letters[index],style: TextStyle(color: Colors.white),)),
                    ),
                    
                );
              }
              )
          
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(selectedString, style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    int isContains = kelimeVarMi(selectedString, kelimeListesi);
                    if (isContains != -1) { //eşleşme durumu
                      acceptedFlow(selectedIndexes);
                      puan = puan + isContains;
                      removeSelected();
                    }
                    if (falseCounter != 3 && isContains == -1) {
                      setState(() {
                        falseCounter++;
                      });
                      
                    }
                  },
                  child: const Text('onayla'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    removeSelected();
                  },
                  child: const Text('sil'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  
}