import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> with WidgetsBindingObserver {
  final otherController = TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    otherController.text = prefs.getString('other') ?? '';
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
    save('other', otherController.text);
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
        save('other', otherController);

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
                        controller: otherController,
                        onChanged: (text) {
                          setState(() {
                            save('other', text);
                          });
                        },
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        maxLines: 200,
                        decoration: const InputDecoration(
                            hintText: '',
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
