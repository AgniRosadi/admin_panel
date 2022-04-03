import 'package:admin_panel/helper/ui/app_color.dart';
import 'package:admin_panel/helper/ui/csi_hex_color.dart';
import 'package:admin_panel/helper/ui/responsive_layout.dart';
import 'package:flutter/material.dart';

class PanelCenterPage extends StatefulWidget {
  const PanelCenterPage({Key? key}) : super(key: key);

  @override
  _PanelCenterPageState createState() => _PanelCenterPageState();
}

class _PanelCenterPageState extends State<PanelCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CsiHexColor("#F3CECD"),
      body: Stack(
        children: [
          if (ResponsiveLayout.isComputer(context) ||
              ResponsiveLayout.isTinyLimit(context) ||
              ResponsiveLayout.isPhone(context) ||
              ResponsiveLayout.isLargeTablet(context) ||
              ResponsiveLayout.isTinyHeightLimit(context) ||
              ResponsiveLayout.isTablet(context))
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppColor.kPadding / 2,
                      right: AppColor.kPadding / 2,
                      top: AppColor.kPadding / 2,
                    ),
                    child: Card(
                      color: Colors.orange,
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        width: double.infinity,
                        child: const ListTile(
                          title: Text(
                            "Products Sold",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "18 % of product sold",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Chip(
                            label: Text(
                              "4,500",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppColor.kPadding / 2,
                      right: AppColor.kPadding / 2,
                      top: AppColor.kPadding / 2,
                    ),
                    child: Card(
                      color: Colors.orange,
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        width: double.infinity,
                        child: const ListTile(
                          title: Text(
                            "Products Sold",
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "18 % of product sold",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Chip(
                            label: Text(
                              "4,500",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
