import 'dart:math';

import 'package:animated_flip_widget/animated_flip_widget/flip_controler.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_bonanza_app/models/card_model.dart';
import 'package:sweet_bonanza_app/models/level_model.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_game/widget/card_widget.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_levels/find_pairs_levels_screen.dart';
import 'package:sweet_bonanza_app/theme/colors.dart';

@RoutePage()
class FindPairsGameScreen extends StatefulWidget {
  final LevelModel level;
  const FindPairsGameScreen({super.key, required this.level});

  @override
  State<FindPairsGameScreen> createState() => _FindPairsGameScreenState();
}

class _FindPairsGameScreenState extends State<FindPairsGameScreen> {
  int startGameTime = DateTime.now().millisecondsSinceEpoch;


  @override
  void initState() {
    super.initState();
    generateCards();
    startGame();
  }

  List<CardModel> cards = [];
  bool isGameOver = false;

  void generateCards() {
    cards = [];
    for (int i = 0; i < widget.level.cardImages.length; i++) {
      final cardValue = i + 1;
      final String image = widget.level.cardImages[i];
      final CardModel newCard = _createCardModel(image, cardValue);
      cards.add(newCard);
    }
    cards.shuffle(Random());
  }

  void resetGame() {
    generateCards();
    isGameOver = false;
  }

  void onCardPressed(int index) {
    setState(() {
      cards[index].state = CardState.visible;
      cards[index].flipController.flip();
    });
    final List<int> visibleCardIndexes = _getVisibleCardIndexes();
    if (visibleCardIndexes.length == 2) {
      final CardModel card1 = cards[visibleCardIndexes[0]];
      final CardModel card2 = cards[visibleCardIndexes[1]];
      if (card1.image == card2.image) {
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;
        isGameOver = _isGameOver();
        if (isGameOver) {
          Future.delayed(const Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.purple,
                content: Text(
                  'Completed!',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            );
            context.router.push(FindPairsLevelsRoute());

          });
        }
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            card1.state = CardState.hidden;
            card2.state = CardState.hidden;
            card1.flipController.flip();
            card2.flipController.flip();
          });
        });
      }
    }
  }

  CardModel _createCardModel(String image, int cardValue) {
    return CardModel(
      flipController: FlipController(),
      value: cardValue,
      image: image,
    );
  }

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  void startGame() {
    for (int i = 0; i < cards.length; i++) {
      cards[i].state = CardState.visible;
      cards[i].flipController.flip();
    }
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        for (int i = 0; i < cards.length; i++) {
          cards[i].state = CardState.hidden;
          cards[i].flipController.flip();

        }
      });
    });
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }

  int endTime() {
    final int levelCountdownTimer =
        widget.level.minutes * 60 * 1000 + widget.level.seconds * 1000;
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
                          isGameOver = true;
                          context.router.push(FindPairsLevelsRoute());
                        },
                        child: SvgPicture.asset(
                            'assets/images/elements/home-button.svg'),
                    ),
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
                            if (isGameOver == false) {
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/find-pairs/stroke.png',
                    height: 540,
                    width: 320),
                  Container(
                    alignment: Alignment.center,
                    height: 500,
                    width: 280,
                    child: GridView.builder(
                      itemCount: cards.length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,),
                      itemBuilder: (BuildContext context, int index) {
                        return CardWidget(
                          index: index,
                          card: cards[index],
                          onCardPressed: onCardPressed,
                        );
                      },
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
