import 'package:sweet_bonanza_app/models/puzzle_pieces_model.dart';

class PuzzleModel {
  final String image;
  final List<PuzzlePieceModel> puzzlePieces;

  PuzzleModel({
    required this.image,
    required this.puzzlePieces,
  });
}