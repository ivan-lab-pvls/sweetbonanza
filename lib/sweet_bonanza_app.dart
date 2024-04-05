import 'package:flutter/material.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/settings/settings_screen.dart';
import 'package:sweet_bonanza_app/services/audio_player.dart';

class SweetBonanzaApp extends StatefulWidget {
  SweetBonanzaApp({super.key});

  @override
  State<SweetBonanzaApp> createState() => _SweetBonanzaAppState();
}

class _SweetBonanzaAppState extends State<SweetBonanzaApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();

  late AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      isPlaying = false;
      AudioPlayerService.audioPlayer.stop();
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Blinker'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
