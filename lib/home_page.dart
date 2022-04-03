import 'package:admin_panel/app_bar/app_bar_widget.dart';
import 'package:admin_panel/drawer/drawer_page.dart';
import 'package:admin_panel/helper/ui/responsive_layout.dart';
import 'package:admin_panel/panel_center/panel_center_page.dart';
import 'package:admin_panel/panel_left/panel_left_page.dart';
import 'package:admin_panel/panel_right/panel_right_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helper/ui/csi_hex_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => _ProviderButtomIndex(),),
    ],child: const HomePageContent(),);
  }
}


class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CsiHexColor("#F3CECD"),
      appBar: PreferredSize(
          child: (ResponsiveLayout.isTinyLimit(context) || ResponsiveLayout.isTinyHeightLimit(context) ? Container() : const AppBarWidget()),
          preferredSize: const Size(double.infinity, 100)),
      body: ResponsiveLayout(
        tiny: Container(),
        phone: context.read<_ProviderButtomIndex>().currentIndex == 0 ? const PanelLeftPage() : context.read<_ProviderButtomIndex>().currentIndex == 1 ? const PanelCenterPage() : const PanelRightPage(),
        tablet: Row(
          children: const [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
          ],
        ),
        largeTablet: Row(
          children: const [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
            Expanded(child: PanelRightPage()),
          ],
        ),
        computer: Row(
          children: const [
            Expanded(child: DrawePage()),
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
            Expanded(child: PanelRightPage()),
          ],
        ),
      ),
      drawer: const DrawePage(),
      bottomNavigationBar: ResponsiveLayout.isPhone(context) ? CurvedNavigationBar(
        index: context.watch<_ProviderButtomIndex>().currentIndex,
        backgroundColor: CsiHexColor("#F3CECD"),
        onTap: (index) {
          context.read<_ProviderButtomIndex>().setCurrentIndex(index);
        },
        items: context.read<_ProviderButtomIndex>()._icons,) : SizedBox(),
    );
  }

}

class _ProviderButtomIndex with ChangeNotifier{
  int currentIndex = 1;
  final List<Widget> _icons = [
    const Icon(Icons.add, size: 30,),
    const Icon(Icons.list, size: 30,),
    const Icon(Icons.compare_arrows, size: 30,)
  ];

  void setCurrentIndex(int currentIndex){
    this.currentIndex = currentIndex;
    notifyListeners();
  }
}

