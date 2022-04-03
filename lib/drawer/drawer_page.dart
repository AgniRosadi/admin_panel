import 'package:admin_panel/helper/ui/app_color.dart';
import 'package:admin_panel/helper/ui/csi_hex_color.dart';
import 'package:admin_panel/helper/ui/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawePage extends StatelessWidget {
  const DrawePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _ProviderIndex(),
        ),
      ],
      child: const _DraweContent(),
    );
  }
}

class _DraweContent extends StatefulWidget {
  const _DraweContent({Key? key}) : super(key: key);

  @override
  _DraweContentState createState() => _DraweContentState();
}

class _DraweContentState extends State<_DraweContent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "Admin Menu",
              style: TextStyle(color: Colors.white),
            ),
            trailing: ResponsiveLayout.isComputer(context)
                ? null
                : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppColor.kPadding),
              child: Consumer<_ProviderIndex>(
                builder: (context, value, child) {
                  if (value._buttonNames.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value._buttonNames.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: index == value._currentIndex
                                  ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [
                                    CsiHexColor("#B14F50"),
                                    Colors.amber.shade50,
                                  ]))
                                  : null,
                              child: ListTile(
                                title: Text(
                                  value._buttonNames[index].title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                leading: Padding(
                                  padding: const EdgeInsets.all(AppColor.kPadding),
                                  child: Icon(
                                    value._buttonNames[index].icon,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  value.setIndex(index);
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.1,
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonsInfo {
  String title;
  IconData icon;

  ButtonsInfo({required this.title, required this.icon});
}

class _ProviderIndex with ChangeNotifier {
  int _currentIndex = 0;

  final List<ButtonsInfo> _buttonNames = [
    ButtonsInfo(title: "Home", icon: Icons.home),
    ButtonsInfo(title: "setting", icon: Icons.settings),
    ButtonsInfo(title: "Notifications", icon: Icons.notifications),
    ButtonsInfo(title: "Contacts", icon: Icons.contact_phone_rounded),
    ButtonsInfo(title: "Sales", icon: Icons.sell),
    ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
    ButtonsInfo(title: "Security", icon: Icons.verified_user),
    ButtonsInfo(title: "Users", icon: Icons.supervised_user_circle_rounded),
  ];

  void setIndex(int current) {
    _currentIndex = current;
    notifyListeners();
  }
}
