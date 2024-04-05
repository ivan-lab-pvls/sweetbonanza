import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_levels/find_pairs_levels_screen.dart';
import 'package:sweet_bonanza_app/widgets/custom_button.dart';

class NewPuzzleScreen extends StatelessWidget {
  final String newPuzzles;

  NewPuzzleScreen({required this.newPuzzles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(newPuzzles),
          ),
        ),
      ),
    );
  }
}

@RoutePage()
class GameSelectionScreen extends StatefulWidget {
  const GameSelectionScreen({super.key});

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
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
                  Column(
                    children: [
                      CustomButton(
                        imageButton: 'assets/images/elements/puzzle.png',
                        onTap: () {
                          context.router.push(PuzzleListRoute());
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        imageButton: 'assets/images/elements/find-pairs.png',
                        onTap: () {
                          context.router.push(FindPairsLevelsRoute());
                        },
                      ),
                    ],
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
