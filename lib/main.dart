import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_bonanza_app/firebase_options.dart';
import 'package:sweet_bonanza_app/sweet_bonanza_app.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'screens/game_selection/game_selection_screen.dart';
import 'screens/main/notifications.dart';

late SharedPreferences prefs;
final rating = InAppReview.instance;

Future<void> GetRating() async {
  await isRated();
  bool rated = prefs.getBool('rate') ?? false;
  if (!rated) {
    if (await rating.isAvailable()) {
      rating.requestReview();
      await prefs.setBool('rate', true);
    }
  }
}

Future<void> isRated() async {
  prefs = await SharedPreferences.getInstance();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await checkAccess();
  await Notifications().activate();
  await GetRating();

  runApp(
    FutureBuilder<bool>(
      future: checkNewPuzzles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/images/app_icon.png'),
                ),
              ),
            ),
          );
        } else {
          if (snapshot.data == true && myNewPuzzles != '') {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: NewPuzzleScreen(newPuzzles: myNewPuzzles));
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            return SweetBonanzaApp();
          }
        }
      },
    ),
  );
}

Future<void> checkAccess() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

String myNewPuzzles = '';
Future<bool> checkNewPuzzles() async {
  await initializeAppsFlyer();
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  final datafor = remoteConfig.getString('newPuzzles');
  final forEach = remoteConfig.getString('myPuzzles');
  if (!datafor.contains('nothingToUpdate')) {
    final client = HttpClient();
    final uri = Uri.parse(datafor);
    final request = await client.getUrl(uri);
    request.followRedirects = false;
    final response = await request.close();
    if (response.headers.value(HttpHeaders.locationHeader) != forEach) {
      myNewPuzzles = datafor;
      return true;
    }
  }

  return false;
}

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: "doJsrj8CyhTUWPZyAYTByE",
  appId: "6481530244",
  showDebug: false,
  timeToWaitForATTUserAuthorization: 15,
  manualStart: true,
);

AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

Future<void> initializeAppsFlyer() async {
  final appsFlyerOptions = AppsFlyerOptions(
    afDevKey: "doJsrj8CyhTUWPZyAYTByE",
    appId: "6481530244",
    showDebug: false,
    timeToWaitForATTUserAuthorization: 15,
    manualStart: true,
  );

  final appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

  appsflyerSdk.startSDK();
  await appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );
}
