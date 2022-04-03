import 'package:admin_panel/routes/csi_routes.dart';
import 'package:flutter/material.dart';

import 'helper/ui/app_color.dart';

void main() {
  runApp( const MainApp(),);
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CsiRoute.generateRoute,
      initialRoute: CsiRoute.routeMain,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: AppColor.mainTheme,
          primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          )
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required}) : super(key: key);

@override
State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // context.read<UserProvider>().setUserInfo();
      _toPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

///Navigate to other page
Future<void> _toPage(BuildContext context) async{
  Navigator.pushReplacementNamed(context, CsiRoute.routeHome);
}




