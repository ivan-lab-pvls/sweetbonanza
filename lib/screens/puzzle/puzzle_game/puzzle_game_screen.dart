import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_bonanza_app/models/puzzle_model.dart';
import 'package:sweet_bonanza_app/models/puzzle_pieces_model.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/puzzle/puzzle_list/puzzle_list_screen.dart';
import 'package:sweet_bonanza_app/theme/colors.dart';

@RoutePage()
class PuzzleGameScreen extends StatefulWidget {
  final PuzzleModel puzzle;

  const PuzzleGameScreen({super.key, required this.puzzle});

  @override
  State<PuzzleGameScreen> createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<PuzzlePieceModel> currentSequence = [];
  List<PuzzlePieceModel> puzzlePieces = [];
  List<PuzzlePieceModel> correctSequence = [];

  int startGameTime = DateTime.now().millisecondsSinceEpoch;

  bool isDone = false;

  int selectedPieceIndex = -1;

  @override
  void initState() {
    initialPuzzle();
    currentSequence = puzzlePieces.toList()..shuffle();
    correctSequence = puzzlePieces.toList()
      ..sort((a, b) => a.index.compareTo(b.index));
    super.initState();
  }

  void initialPuzzle() {
    puzzlePieces = widget.puzzle.puzzlePieces;
  }

  void checkSequence() {
    if (listEquals(currentSequence, correctSequence)) {
      isDone = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.purple,
          content: Text(
            'Puzzle completed!',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        context.router.push(PuzzleListRoute());
      });
    }
  }

  void swapPieces(int index1, int index2) {
    List<PuzzlePieceModel> newSequence = List.from(currentSequence);
    PuzzlePieceModel temp = newSequence[index1];
    newSequence[index1] = newSequence[index2];
    newSequence[index2] = temp;
    setState(() {
      currentSequence = newSequence;
      checkSequence();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  int endTime() {
    final int levelCountdownTimer = 1 * 60 * 1000 + 30 * 1000;
    final int timeLeft = levelCountdownTimer -
        (DateTime.now().millisecondsSinceEpoch - startGameTime);
    return DateTime.now().millisecondsSinceEpoch + timeLeft;
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          isDone = true;
                          context.router.push(PuzzleListRoute());
                        },
                        child: SvgPicture.asset(
                            'assets/images/elements/home-button.svg')),
                    Row(
                      children: [
                        Text(
                          'Time: ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CountdownTimer(
                          textStyle: TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                          endTime: endTime(),
                          onEnd: () {
                            if (isDone == false) {
                              context.router.push(PuzzleListRoute());
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
              Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.puzzle.image,
                        width: 170,
                      )),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 170,
                    child: Text(
                      'Put the puzzles together to make this pichure',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.white),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.purple,
                    ),
                    padding: EdgeInsets.all(10),
                    height: 350,
                    width: 350,
                    child: Center(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: currentSequence.length,
                        itemBuilder: (context, index) {
                          PuzzlePieceModel piece = currentSequence[index];
                          return DragTarget<int>(
                            onAccept: (int draggedIndex) {
                              swapPieces(draggedIndex, index);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Draggable<int>(
                                data: index,
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  color: Colors.white,
                                  child: Center(
                                    child: Image.asset(piece.pieces),
                                  ),
                                ),
                                feedback: Container(
                                  margin: EdgeInsets.all(2),
                                  color: Colors.white,
                                  child: Center(
                                    child: Image.asset(piece.pieces, width: 100, height: 100,),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
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
