import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerService {
  static final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  static void open(Audio audio) {
    audioPlayer.open(audio);
  }

  static void play() {
    audioPlayer.play();
  }

  static void pause() {
    audioPlayer.pause();
  }

  static void dispose() {
    audioPlayer.dispose();
  }

}