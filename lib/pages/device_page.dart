import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifePage extends StatefulWidget {
  const LifePage({Key? key}) : super(key: key);

  @override
  _LifePageState createState() => _LifePageState();
}

class _LifePageState extends State<LifePage> with WidgetsBindingObserver {
  final deviceController = TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    deviceController.text = prefs.getString('device') ?? '';
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
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);
    save('device', deviceController.text);
    print("contText ${deviceController.text}");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("stete = $state");
    switch (state) {
      case AppLifecycleState.inactive:
        print('非アクティブになったときの処理');
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        break;
      case AppLifecycleState.detached:
        print('破棄されたときの処理');
        save('device', deviceController);
        print(
            "controller : $deviceController  +  contText ${deviceController.text}");

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
                        controller: deviceController,
                        onChanged: (text) {
                          print("4");
                          setState(() {
                            save('device', text);
                          });
                        },
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        maxLines: 200,
                        decoration: const InputDecoration(
                            hintText: '画面ロック 1234',
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
