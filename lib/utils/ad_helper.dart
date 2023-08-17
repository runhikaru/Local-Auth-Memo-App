import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AdHelper {
  //Test AdMob ID
  // static String bannerId="ca-app-pub-3940256099942544/6300978111";
  // static String interstitialId="ca-app-pub-3940256099942544/1033173712";
  // static String rewordId='ca-app-pub-3940256099942544/8673189370';

  //本番 AdMob ID
  static String bannerId = "ca-app-pub-9774750874955739/2290169494";
  static String interstitialId = "ca-app-pub-9774750874955739/8664006157";
  static String rewordId = 'ca-app-pub-9774750874955739/4724761143';

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return bannerId;
    } else if (Platform.isIOS) {
      return bannerId;
    } else {
      throw UnsupportedError("このプラットフォームでは対応していません");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return interstitialId;
    } else if (Platform.isIOS) {
      return interstitialId;
    } else {
      throw UnsupportedError("このプラットフォームでは対応していません");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return rewordId;
    } else if (Platform.isIOS) {
      return rewordId;
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}

class SimplePreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
}
