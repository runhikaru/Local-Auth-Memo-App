import 'package:flutter/material.dart';
import 'package:memo_lock_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MailPage extends StatefulWidget {
  const MailPage({Key? key}) : super(key: key);
  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> with WidgetsBindingObserver {
  final mailController = TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    mailController.text = prefs.getString('mail') ?? '';
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
    save('mail', mailController.text);
    print("contText ${mailController.text}");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print("stete = $state");
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
        save('mail', mailController);
        // print(
        //     "controller : $mailController  +  contText ${mailController.text}");

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
                    controller: mailController,
                    onChanged: (text) {
                      setState(() {
                        save('mail', text);
                      });
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    maxLines: 200,
                    decoration: const InputDecoration(
                        hintText: 'メール example@mail.com\nパス 123456',
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
