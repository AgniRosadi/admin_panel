import 'dart:ui';

class CsiHexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    if(hexColor.isEmpty){
      hexColor = "#ffffff";
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  CsiHexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}