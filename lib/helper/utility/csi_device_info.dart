import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

///Get device info
class CsiDeviceInfo{
  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      return info.androidId ?? "";
    }else if(Platform.isIOS){
      IosDeviceInfo info = await deviceInfo.iosInfo;
      return info.identifierForVendor ?? "";
    }else{
      return "";
    }
  }
}