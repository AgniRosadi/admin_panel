import 'package:admin_panel/helper/constant/csi_settings.dart';

class CsiDevTool {
  ///Print Object only on debug mode flag, if CsiSettings.isDebug == true
  static printDev(Object? object){
    if(CsiSettings.isDebug){
      print(object);
    }
  }
}