



import 'package:sweet_bonanza_app/models/puzzle_model.dart';
import 'package:sweet_bonanza_app/models/puzzle_pieces_model.dart';

final List<PuzzleModel> puzzleRepository = [
  PuzzleModel(
      image: 'assets/images/puzzle/1/full-1.png',
      puzzlePieces: List<PuzzlePieceModel>.generate(
          9,
              (i) => PuzzlePieceModel(
              index: i, pieces: 'assets/images/puzzle/1/${i + 1}.png'))),
  PuzzleModel(
      image: 'assets/images/puzzle/2/full-2.png',
      puzzlePieces: List<PuzzlePieceModel>.generate(
          9,
              (i) => PuzzlePieceModel(
              index: i, pieces: 'assets/images/puzzle/2/${i + 1}.png'))),
  PuzzleModel(
      image: 'assets/images/puzzle/3/full-3.png',
      puzzlePieces: List<PuzzlePieceModel>.generate(
          9,
              (i) => PuzzlePieceModel(
              index: i, pieces: 'assets/images/puzzle/3/${i + 1}.png'))),
  PuzzleModel(
      image: 'assets/images/puzzle/4/full-4.png',
      puzzlePieces: List<PuzzlePieceModel>.generate(
          9,
              (i) => PuzzlePieceModel(
              index: i, pieces: 'assets/images/puzzle/4/${i + 1}.png'))),
  PuzzleModel(
      image: 'assets/images/puzzle/5/full-5.png',
      puzzlePieces: List<PuzzlePieceModel>.generate(
          9,
              (i) => PuzzlePieceModel(
              index: i, pieces: 'assets/images/puzzle/5/${i + 1}.png'))),
];