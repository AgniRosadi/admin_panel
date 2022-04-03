import 'dart:io';

/// Allow https self signed certificate
/// Place HttpOverrides.global = CustomHttpOverrides(); on main.dart before runApp()
/// Disable this after server-side sll fully configured
class CustomHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}