import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_bonanza_app/services/audio_player.dart';
import 'package:sweet_bonanza_app/widgets/custom_button.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

bool isPlaying = false;

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  final browser = InAppBrowser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/elements/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: SvgPicture.asset(
                            'assets/images/elements/home-button.svg')),
                    SizedBox(width: 5),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Column(
                children: [
                  Image.asset('assets/images/elements/logo.png'),
                  Column(
                    children: [
                      CustomButton(
                        imageButton: 'assets/images/elements/privacy.png',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (BuildContext context) => const TRMS(
                                    trms:
                                        'https://docs.google.com/document/d/1KoQaOHv6_j3XQNZMJlWBa3AkbqN-A80r4PjCIf9D9vs/edit?usp=sharing',
                                  )));
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        imageButton: 'assets/images/elements/terms.png',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => const TRMS(
                                      trms:
                                          'https://docs.google.com/document/d/1nDwvrlH3xggHi3pjBJKh2Y1gWGnoRY_TKso77BOU9Bk/edit?usp=sharing',
                                    )),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        imageButton: 'assets/images/elements/music.png',
                        onTap: () {
                          if (isPlaying) {
                            isPlaying = false;
                            AudioPlayerService.audioPlayer.stop();
                          } else {
                            isPlaying = true;
                            AudioPlayerService.audioPlayer.open(
                                Playlist(audios: [
                                  Audio('assets/audios/adventure-time.mp3')
                                ]),
                                loopMode: LoopMode.playlist);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class TRMS extends StatelessWidget {
  final String trms;

  const TRMS({Key? key, required this.trms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(trms)),
        ),
      ),
    );
  }
}
