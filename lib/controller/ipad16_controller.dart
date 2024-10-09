import 'package:flutter/material.dart';

class Ipad16Controller extends ChangeNotifier {
 

  String selectedAlphabet ='';

  void changeColor({required String selectedValue}) {
    selectedAlphabet =  selectedValue; 
    notifyListeners(); 
  }
}
