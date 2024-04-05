import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sweet_bonanza_app/models/level_model.dart';
import 'package:sweet_bonanza_app/repository/find_pairs_repository.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_game/find_pairs_game_screen.dart';
import 'package:sweet_bonanza_app/theme/colors.dart';

@RoutePage()
class FindPairsLevelsScreen extends StatefulWidget {
  const FindPairsLevelsScreen({super.key});

  @override
  State<FindPairsLevelsScreen> createState() => _FindPairsLevelsScreenState();
}

class _FindPairsLevelsScreenState extends State<FindPairsLevelsScreen> {
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
                          context.router.push(MainRoute());
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
                  StrokeText(
                    text: "Levels",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 70,
                        color: AppColors.purple),
                    strokeColor: Colors.white,
                    strokeWidth: 4,
                  ),
                  SizedBox(
                    height: 300,
                    width: 320,
                    child: GridView.builder(
                      itemCount: findPairsRepository.length,
                      padding: EdgeInsets.all(16),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        final LevelModel _level = findPairsRepository[index];
                        return GestureDetector(
                          onTap: () {
                            context.router.push(FindPairsGameRoute(level: _level));
                          },
                          child: Image.asset(_level.levelButton),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
