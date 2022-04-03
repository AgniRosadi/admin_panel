import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ndialog/ndialog.dart';

///Dialog action on user interaction
enum CsiDialogAction { yes, no, neutral, dismiss }

///Dialog type
enum CsiDialogType { info, success, warning, error }

///Show alert dialog and progress dialog
class CsiDialogs {
  static ProgressDialog? progressDialog;

  ///Show confirmation dialog
  ///Parameters :
  ///- context, required
  ///- title, required
  ///- message, required
  ///- yesButtonLabel, set displayed text on yes button, optional
  ///- noButtonLabel, set displayed text on no button, optional
  ///- neutralButtonLabel, set displayed text and create neutral button, optional
  ///- icon, set yout desired icon using IconData.class, optional
  static Future<CsiDialogAction> confirmDialog(
      {required BuildContext context,
      required String title,
      required String message,
      String yesButtonLabel = "YES",
      String noButtonLabel = "NO",
      String neutralButtonLabel = "-1",
      IconData icon = Icons.info_outline}) async {
    Widget yesButton = ElevatedButton(
      child: Text(
        yesButtonLabel,
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(CsiDialogAction.yes);
      },
    );

    Widget noButton = OutlinedButton(
      child: Text(
        noButtonLabel,
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(CsiDialogAction.no);
      },
    );

    Widget neutralButton = TextButton(
      child: Text(
        neutralButtonLabel,
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(CsiDialogAction.neutral);
      },
    );

    List<Widget> actionButtons = <Widget>[];

    if (neutralButtonLabel != "-1") {
      actionButtons.add(neutralButton);
    }
    actionButtons.addAll([
      noButton,
      yesButton,
    ]);

    AlertDialog alert = AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 80.0,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
      actions: actionButtons,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
      ),
    );

    final action = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return (action != null) ? action : CsiDialogAction.dismiss;
  }

  ///Show result dialog or information dialog
  ///Parameters :
  ///- context, required
  ///- title, required
  ///- message, required
  ///- okButtonLabel, set displayed text on ok button, required
  ///- dialogType, set theme of dialog, required
  static Future<CsiDialogAction> resultDialog(
      {required BuildContext context,
      required String title,
      required String message,
      String okButtonLabel = "OK",
      CsiDialogType dialogType = CsiDialogType.info}) async {
    Widget okButton = ElevatedButton(
      child: Text(
        okButtonLabel,
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(CsiDialogAction.yes);
      },
    );

    Widget infoIcon = const Icon(
      Icons.info_outline,
      color: Colors.indigo,
      size: 80.0,
    );

    Widget successIcon = const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: 80.0,
    );
    Widget warningIcon = const Icon(
      Icons.warning_amber_outlined,
      color: Colors.orange,
      size: 80.0,
    );
    Widget errorIcon = const Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 80.0,
    );

    Widget icon = infoIcon;

    if (dialogType == CsiDialogType.info) {
      icon = infoIcon;
    } else if (dialogType == CsiDialogType.success) {
      icon = successIcon;
    } else if (dialogType == CsiDialogType.warning) {
      icon = warningIcon;
    } else if (dialogType == CsiDialogType.error) {
      icon = errorIcon;
    }

    AlertDialog alert = AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
        ],
      ),
      actions: [okButton],
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
      ),
    );

    final action = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return (action != null) ? action : CsiDialogAction.dismiss;
  }

  ///Show progress dialog
  static Future<CsiDialogAction> showProgressDialog(
      {required BuildContext context, required String title, required String message, bool isDismissible = true}) async {
    progressDialog = ProgressDialog(
      context,
      message: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 17),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 22),
      ),
      dismissable: isDismissible,
      onDismiss: () {
        return CsiDialogAction.dismiss;
      },
    );

    progressDialog!.show();
    return CsiDialogAction.neutral;
  }

  ///Hide progress dialog
  static Future<void> hideProgressDialog() async {
    if (progressDialog != null) {
      progressDialog!.dismiss();
    }
  }

  ///Update progress dialog
  static Future<void> updateProgressDialog({required String title, required String message, bool isDismissable = true}) async {
    if (progressDialog != null) {
      progressDialog!.setTitle(Text(title));
      progressDialog!.setMessage(Text(message));
    }
  }
}
