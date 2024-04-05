import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sweet_bonanza_app/models/puzzle_model.dart';
import 'package:sweet_bonanza_app/repository/puzzle_repository.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/theme/colors.dart';

@RoutePage()
class PuzzleListScreen extends StatefulWidget {
  const PuzzleListScreen({super.key});

  @override
  State<PuzzleListScreen> createState() => _PuzzleListScreenState();
}

class _PuzzleListScreenState extends State<PuzzleListScreen> {
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
                  Image.asset('assets/images/elements/logo.png'),
                  StrokeText(
                    text: "Puzzle",
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 50,
                        color: AppColors.purple),
                    strokeColor: Colors.white,
                    strokeWidth: 4,
                  ),
                  Text(
                    'Choice which image of the puzzle you will assemble',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.white),
                  ),
                  SizedBox(
                    height: 360,
                    width: 250,
                    child: GridView.builder(
                      itemCount: puzzleRepository.length,
                      padding: EdgeInsets.all(16),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (BuildContext context, int index) {
                        final PuzzleModel _puzzle = puzzleRepository[index];
                        return GestureDetector(
                          onTap: () {
                            context.router.push(PuzzleGameRoute(puzzle: _puzzle));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(_puzzle.image, width: 90),
                          ),
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
