import 'dart:convert';
import 'package:admin_panel/helper/utility/csi_dev_tool.dart';
import 'package:admin_panel/routes/csi_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '/helper/ui/csi_dialog.dart';
import '/helper/utility/csi_log.dart';
import '/helper/utility/csi_shared_prefs.dart';

/// API handler
class ApiHandler {
  ///Check validity of API request and give default response to invalid API request
  static Future<bool> validate(BuildContext context, Response response, [isApiLogin = false]) async {
    //remove any focus on screed, ex: focus on editext
    FocusScope.of(context).requestFocus(FocusNode());
    CsiDialogs.hideProgressDialog();
    try {
      if (response.statusCode == 200) {
        if (response.data == null) {
          await CsiDialogs.resultDialog(context: context, title: "Error", message: "Invalid Data, failed to fetch 1.", dialogType:  CsiDialogType.error);
          return false;
        }
        if (response.data.toString().isEmpty) {
          await CsiDialogs.resultDialog(context: context, title: "Error", message: "Invalid Data, failed to fetch 2.", dialogType:  CsiDialogType.error);
          return false;
        }
        var jsonResponse = response.data;
        CsiDevTool.printDev(json.encode(jsonResponse));
        String statusCode = jsonResponse['statusCode'].toString();
        if (statusCode != "200") {
          ///401, Unauthenticated/Token Session Expired
          if(statusCode=="401"){
            ///This should be returned differennt statucCode from backend, for now use isApiLogin flag to handle 401.
            if(isApiLogin){
              await CsiDialogs.resultDialog(
                  context: context,
                  title: jsonResponse['error']['type'],
                  message: jsonResponse['error']['description'],
                  dialogType: CsiDialogType.error);
            }else{
              await CsiDialogs.resultDialog(context: context, title: "Unauthenticated", message: "Your session has ended, please login again.");
              await CsiSharedPrefs.setLogin(false);
              // Navigator.pushReplacementNamed(context, CsiRoute.routeMain);
            }

          }else{
            await CsiDialogs.resultDialog(
                context: context,
                title: "Failed",
                message: jsonResponse['error']['type'] + "\n" + jsonResponse['error']['description'],
                dialogType: CsiDialogType.error);
          }
          return false;
        }
        ///API VALID return true;
        return true;
      } else {
        if (response.statusCode == -1) {
          //No connection/server unreachable
          await CsiDialogs.resultDialog(
              context: context, title: "Failed", message: response.statusMessage.toString(), dialogType: CsiDialogType.error);
        } else {
          await CsiDialogs.resultDialog(
              context: context,
              title: "Error",
              message: "Something went wrong.1 \ncode:" + response.statusCode.toString() + "\nmsg:" + response.statusMessage.toString(),
              dialogType: CsiDialogType.error);
        }
        return false;
      }
    } catch (e) {
      await CsiLog.logError(e);
      await CsiDialogs.resultDialog(
          context: context,
          title: "Error",
          message: "Something went wrong.2 \n(details: " + e.toString() + ")",
          dialogType: CsiDialogType.error);
      return false;
    }
  }
}
