import 'package:flutter/material.dart';

class VariablesExt with ChangeNotifier {
  String _data = ""; // data predeterminado
  String get data => _data;
  void setdata(String newdata) {
    _data = newdata;
    notifyListeners();
  }

  String _correo = "GonzaloQuintana@techmall.com";
  String get correo => _correo;
  void setcorreo(String newcorreo) {
    _correo = newcorreo;
    notifyListeners();
  }

  String _url = ""; // URL predeterminado
  String get url => _url;
  void setUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }

  String _hacienda = ""; // URL predeterminado
  String get hacienda => _hacienda;
  void sethacienda(String newhacienda) {
    _hacienda = newhacienda;
    notifyListeners();
  }

  String _hacienda2 = ""; // URL predeterminado
  String get hacienda2 => _hacienda2;
  void sethacienda2(String newhacienda2) {
    _hacienda2 = newhacienda2;
    notifyListeners();
  }

  String _lote = ""; // URL predeterminado
  String get lote => _lote;
  void setlote(String newlote) {
    _lote = newlote;
    notifyListeners();
  }

  String _fecha = ""; // URL predeterminado
  String get fecha => _fecha;
  void setfecha(String newfecha) {
    _fecha = newfecha;
    notifyListeners();
  }
}
