// import 'package:app_review/app_review.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:psword_portal_app/utils/ad_helper.dart';
// import 'package:share/share.dart';

// import 'home_page.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   late BannerAd _bannerAd;

//   bool _isBannerAdReady = false;

//   bool _isRewardedAdReady = false;

//   RewardedAd? _rewardedAd;

//   @override
//   void initState() {
//     super.initState();

//     _bannerAd = BannerAd(
//         // Change Banner Size According to Ur Need
//         size: AdSize.mediumRectangle,
//         adUnitId: AdHelper.bannerAdUnitId,
//         listener: BannerAdListener(onAdLoaded: (_) {
//           setState(() {
//             _isBannerAdReady = true;
//           });
//         }, onAdFailedToLoad: (ad, LoadAdError error) {
//           print("このロードに失敗しました Error Message : ${error.message}");
//           _isBannerAdReady = false;
//           ad.dispose();
//         }),
//         request: AdRequest())
//       ..load();

//     _loadRewardedAd();

//     hideBar();
//   }

//   void _loadRewardedAd() {
//     RewardedAd.load(
//       adUnitId: AdHelper.rewardedAdUnitId,
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
//         this._rewardedAd = ad;
//         ad.fullScreenContentCallback =
//             FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
//           setState(() {
//             _isRewardedAdReady = false;
//           });
//           _loadRewardedAd();
//         });
//         setState(() {
//           _isRewardedAdReady = true;
//         });
//       }, onAdFailedToLoad: (error) {
//         print('このロードに失敗しました Error Message :  ${error.message}');
//         setState(() {
//           _isRewardedAdReady = false;
//         });
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _bannerAd.dispose();
//   }

//   Future hideBar() =>
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//   void _requestReview() {
//     AppReview.requestReview.then((onValue) => print(onValue));
//   }

//   void _share() => Share.share(
//       'パスワード管理アプリ！コピペで即ログインっ！\nアプリ⇨https://apps.apple.com/us/app/%E3%83%91%E3%82%B9%E3%83%9D%E3%83%BC%E3%82%BF%E3%83%AB/id1627944960');

//   @override
//   Widget build(BuildContext context) {
//     const styleTitle = TextStyle(color: Colors.white);
//     const styleSubTitle = TextStyle(color: Colors.grey);
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text("サポート", style: styleSubTitle),
//               ),
//               /*
//               _isRewardedAdReady
//                   //リワード広告
//                   ? ListTile(
//                       title: Text('広告支援', style: styleTitle),
//                       subtitle: Text(
//                         "動画広告を視聴する",
//                         style: styleSubTitle,
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 15,
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SettingsPage()));
//                         _rewardedAd?.show(
//                           onUserEarnedReward: (_, reward) {},
//                         );
//                       },
//                     )
//                   : CircularProgressIndicator(
//                       backgroundColor: Colors.grey,
//                       color: Colors.red,
//                     ),
//                     */
//               ListTile(
//                 title: Text(
//                   '評価',
//                   style: styleTitle,
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//                 onTap: () {
//                   _requestReview();
//                 },
//               ),
//               ListTile(
//                 title: Text(
//                   'シェア',
//                   style: styleTitle,
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//                 onTap: () {
//                   _share();
//                 },
//               ),
//               SizedBox(
//                 height: 60,
//               ),
//               //Banner広告
//               if (_isBannerAdReady)
//                 SizedBox(
//                   height: _bannerAd.size.height.toDouble(),
//                   width: _bannerAd.size.width.toDouble(),
//                   child: AdWidget(ad: _bannerAd),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
