import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'csi_date.dart';
import 'csi_io.dart';

///Read and write log error to file
class CsiLog {

  static Future<String> _logErrorPath() async {
    final path = await CsiIO.getDir() + "/logs/error.txt";
    return path;
  }

  ///Log error from exception
  static Future<void> logError(Object catchobj) async {
    logErrorText(catchobj.toString());
  }
  static Future<void> logErrorException(Exception exception) async {
    logErrorText(exception.toString());
  }

  ///Log error from provided text
  static Future<void> logErrorText(String text) async {
    //if not website then make log file
    if(!kIsWeb){
      String textf = "["+CsiDate.getCurrentDateTime()+"] : "+text;
      String path = await _logErrorPath();
      bool exist = await CsiIO.isFileExist(path);
      final File file = File(path);
      if(!exist){
        await file.create(recursive: true).then((value) async {
          await file.writeAsString(textf);
        }).onError((error, stackTrace) {
          log(stackTrace.toString());
        });
      }else{
        await file.writeAsString("\n"+textf, mode: FileMode.append);
      }
    }

  }
  ///Read log error as string
  static Future<String> readLogError() async {
    if(!kIsWeb) {
      String path = await _logErrorPath();
      bool exist = await CsiIO.isFileExist(path);
      if (exist) {
        final File file = File(path);
        String text = await file.readAsString();
        //log(text);
        return text;
      } else {
        return "No error.";
      }
    }else{
      return "Log web on server.";
    }
  }


}
