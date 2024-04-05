class LevelModel {
  final String levelButton;
  final int number;
  final List<String> cardImages;
  int minutes;
  int seconds;

  LevelModel(
      {required this.cardImages,
        required this.levelButton,
        required this.minutes,
        required this.seconds,
        required this.number});
}