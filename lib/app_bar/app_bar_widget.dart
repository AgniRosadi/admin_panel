import 'package:admin_panel/helper/ui/app_color.dart';
import 'package:admin_panel/helper/ui/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _ProviderButton(),
        )
      ],
      child: const AppBarWidgetContent(),
    );
  }
}

class AppBarWidgetContent extends StatefulWidget {
  const AppBarWidgetContent({Key? key}) : super(key: key);

  @override
  _AppBarWidgetContentState createState() => _AppBarWidgetContentState();
}

class _AppBarWidgetContentState extends State<AppBarWidgetContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ResponsiveLayout.isComputer(context))
              Container(
                margin: const EdgeInsets.all(AppColor.kPadding),
                height: double.infinity,
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child:  Image(image: AssetImage("images/infinity.png"),width: 50,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("CSI ", style: TextStyle(fontSize: 30, color: Colors.white),),
                    )
                  ],
                ),
              )
            else
              IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  iconSize: 30,
                  color: Colors.white,
                  icon: const Icon(Icons.menu)),
            const SizedBox(
              width: AppColor.kPadding,
            ),const Spacer(),
            if (ResponsiveLayout.isComputer(context))
              ...List.generate(
                  _buttonNames.length,
                  (index) => TextButton(
                      onPressed: () {
                        // setState(() {
                        //   _currentSelectedButton = index;
                        // });
                       context.read<_ProviderButton>().setSelectedButton(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppColor.kPadding * 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _buttonNames[index],
                              style: TextStyle(color: context.watch<_ProviderButton>()._currentSelectedButton == index ? Colors.white : Colors.white70),
                            ),
                            Container(
                              margin: const EdgeInsets.all(AppColor.kPadding / 2),
                              width: 60,
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: context.watch<_ProviderButton>()._currentSelectedButton == index ? LinearGradient(colors: [Colors.red, Colors.orange]) : null,
                              ),
                            )
                          ],
                        ),
                      )))
            else
              Padding(
                padding: const EdgeInsets.all(AppColor.kPadding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _buttonNames[context.watch<_ProviderButton>()._currentSelectedButton],
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                        margin: EdgeInsets.all(AppColor.kPadding / 2),
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.shade200, Colors.orange.shade50])))
                  ],
                ),
              ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
              iconSize: 30,
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined),
                  color: Colors.white,
                  iconSize: 30,
                ),
                const Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 8,
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            if (!ResponsiveLayout.isPhone(context))
              Container(
                margin: const EdgeInsets.all(AppColor.kPadding),
                height: double.infinity,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black45, offset: Offset(0, 0), spreadRadius: 1, blurRadius: 5)], shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: FaIcon(FontAwesomeIcons.user),
                ),
              )
          ],
        ),
      ),
    );
  }
}

List<String> _buttonNames = ["OverView", "Revenue", "Sales", "Control"];
// int _currentSelectedButton = 0;

class _ProviderButton with ChangeNotifier {
  int _currentSelectedButton = 0;

  void setSelectedButton(int current) {
    _currentSelectedButton = current;
    print(_currentSelectedButton);
    notifyListeners();
  }
}
