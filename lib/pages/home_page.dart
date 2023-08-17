import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo_lock_app/main.dart';

import 'app_page.dart';
import 'device_page.dart';
import 'mail_page.dart';
import 'other_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  bool isExtended = false;

  @override
  void initState() {
    super.initState();
    hideBar();
  }

  Future hideBar() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                NavigationRail(
                  backgroundColor: Colors.white,
                  selectedIndex: index,
                  extended: isExtended,
                  selectedIconTheme:
                      const IconThemeData(color: Colors.black, size: 50),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.grey,
                  ),
                  onDestinationSelected: (index) =>
                      setState(() => this.index = index),
                  leading: IconButton(
                      onPressed: () {
                        // setState(() => isExtended = !isExtended);
                        Navigator.push(context,
                        MaterialPageRoute(builder: (cotext) => LoginPage()));
                      },
                      icon: isExtended
                          ? const Icon(Icons.keyboard_double_arrow_left_rounded,
                              color: Colors.black, size: 30)
                          : const Icon(Icons.keyboard_double_arrow_right,
                              color: Colors.black, size: 30)),
                  destinations: [
                    NavigationRailDestination(
                        icon: Icon(Icons.mail), label: Text('メール')),
                    NavigationRailDestination(
                        icon: Icon(Icons.border_color_rounded),
                        label: Text('メモ')),
                    NavigationRailDestination(
                        icon: Icon(Icons.home), label: Text('生活')),
                    NavigationRailDestination(
                        icon: Icon(Icons.chat), label: Text('その他')),
                  ],
                ),
                Expanded(child: buildPages()),
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.white,
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => SettingsPage()));
          //   },
          //   child: Icon(
          //     Icons.settings,
          //     color: Colors.black,
          //   ),
          // ),
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return const MailPage();
      case 1:
        return const MemoPage();
      case 2:
        return const LifePage();
      case 3:
        return const OtherPage();
      // case 4:
      // return const SettingsPage();

      default:
        return MailPage();
    }
  }
}
