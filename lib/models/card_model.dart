
import 'package:animated_flip_widget/animated_flip_widget.dart';

enum CardState { hidden, visible, guessed }

class CardModel {
  final int value;
  final String image;
  CardState state;
  final FlipController flipController;

  CardModel( {
    required this.value,
    required this.image,
    required this.flipController,
    this.state = CardState.hidden,
  });
}