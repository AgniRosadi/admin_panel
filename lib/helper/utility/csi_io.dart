import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

///Input Output utils
class CsiIO {

  ///Get app local derectory
  static Future<String> getDir() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  ///Check if file exist
  static Future<bool> isFileExist(String path) async{
    return File(path).exists();
  }

  ///Check if directory exist
  static Future<bool> isDirectoryExist(String path) async{
    return Directory(path).exists();
  }

  ///Format bytes
  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1000)).floor();
    return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

}