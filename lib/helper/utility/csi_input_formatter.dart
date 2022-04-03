import 'package:flutter/services.dart';

///used in texfile inputFormatter
class CsiInputFormatter {

  static TextInputFormatter decimal(){
    return FilteringTextInputFormatter.allow(RegExp(r'^\d*\,?\d{0,2}'));
  }

}