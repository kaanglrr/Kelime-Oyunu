import 'dart:math';
import 'dart:io';

  var harfPuanListesi = {
    "a": 1,
    "b": 3,
    "c": 4,
    "ç": 4,
    "d": 3,
    "e": 1,
    "f": 7,
    "g": 5,
    "ğ": 8,
    "h": 5,
    "ı": 2,
    "i": 1,
    "j": 10,
    "k": 1,
    "l": 1,
    "m": 2,
    "n": 1,
    "o": 2,
    "ö": 7,
    "p": 5,
    "r": 1,
    "s": 2,
    "ş": 4,
    "t": 1,
    "u": 2,
    "ü": 3,
    "v": 7,
    "y": 3,
    "z": 4,
  };

  var BuyukHarfListesi = {
    "a": "A",
    "b": "B",
    "c": "C",
    "ç": "Ç",
    "d": "D",
    "e": "E",
    "f": "F",
    "g": "G",
    "ğ": "Ğ",
    "h": "H",
    "ı": "I",
    "i": "İ",
    "j": "J",
    "k": "K",
    "l": "L",
    "m": "M",
    "n": "N",
    "o": "O",
    "ö": "Ö",
    "p": "P",
    "r": "R",
    "s": "S",
    "ş": "Ş",
    "t": "T",
    "u": "U",
    "ü": "Ü",
    "v": "V",
    "y": "Y",
    "z": "Z",
  };

  var BuyukkHarfListesi = {
    "A": "a",
    "B": "b",
    "C": "c",
    "Ç": "ç",
    "D": "d",
    "E": "e",
    "F": "f",
    "G": "g",
    "Ğ": "ğ",
    "H": "h",
    "I": "ı",
    "İ": "i",
    "J": "j",
    "K": "k",
    "L": "l",
    "M": "m",
    "N": "n",
    "O": "o",
    "Ö": "ö",
    "P": "p",
    "R": "r",
    "S": "s",
    "Ş": "ş",
    "T": "t",
    "U": "u",
    "Ü": "ü",
    "V": "v",
    "Y": "y",
    "Z": "z",
  };

  int kelimePuanHesapla(String kelime) {
    int puan = 0;
    var harfler = kelime.split('');
    for (var harf in harfler) {
      puan = puan + harfPuanListesi[BuyukkHarfListesi[harf]]!;
    }
    return puan;
  }

  String kelimeKucult(String kelime) {
    var harfler = kelime.split('');
    String temp = "";
    for (var harf in harfler) {
      temp = temp + BuyukkHarfListesi[harf]!;
    }
    return temp;
  }

  int kelimeVarMi(String kelime, var kelimeListesi) {
    if (kelimeListesi.contains(kelimeKucult(kelime))) {
      return kelimePuanHesapla(kelime);
    } else {
      return -1;
    }
  }
    
var sesli_harf = ["A", "E", "I", "İ", "O", "Ö", "U", "Ü"];
var sessiz_harf = [
  "Z",
  "Y",
  "V",
  "T",
  "Ş",
  "S",
  "R",
  "P",
  "N",
  "R",
  "M",
  "L",
  "K",
  "H",
  "J",
  "Ğ",
  "G",
  "D",
  "Ç",
  "C",
  "B"
];

List randomHarfListesi(int loop) {
  List<String> karakter_listesi = [];
  for (int i = 0; i < loop; i++) {
    karakter_listesi.add(randomHarf());
  }
  return karakter_listesi;
}

String randomHarf() {
  var randomNumberGenerator = Random();
  var randomBoolean = randomNumberGenerator.nextInt(10);
  var index = 0;
  var karakter;
  if (randomBoolean >= 6) {
    index = randomNumberGenerator.nextInt(7); // true ise sesli harf
    //print(sesli_harf[index]);
    karakter = sesli_harf[index];
  } else {
    index = randomNumberGenerator.nextInt(20); // false ise sessiz harf
    karakter = sessiz_harf[index];
    //print(sessiz_harf[index]);
  }
  return karakter;
  }