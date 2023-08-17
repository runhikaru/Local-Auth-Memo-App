import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> with WidgetsBindingObserver {
  final appController = TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    appController.text = prefs.getString('app') ?? '';
    setState(() {
      isLoaded = true;
    });
  }

  //データ保存用関数
  Future<void> save(key, text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    save('app', appController.text);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        //非アクティブになったときの処理
        break;
      case AppLifecycleState.paused:
        //停止されたときの処理
        break;
      case AppLifecycleState.resumed:
        //再開されたときの処理
        break;
      case AppLifecycleState.detached:
        //破棄されたときの処理
        save('app', appController);

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Visibility(
        visible: isLoaded,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: TextField(
                    controller: appController,
                    onChanged: (text) {
                      setState(() {
                        save('app', text);
                      });
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    maxLines: 200,
                    decoration: const InputDecoration(
                        hintText: 'アプリ 〇〇\nユーザーID user\nps 123456',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18))),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
