import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sweet_bonanza_app/router/router.dart';
import 'package:sweet_bonanza_app/screens/game_selection/game_selection_screen.dart';
import 'package:sweet_bonanza_app/widgets/custom_button.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/elements/logo.png'),
              Column(
                children: [
                  CustomButton(
                    imageButton: 'assets/images/elements/levels.png',
                    onTap: () {
                      context.router.push(GameSelectionRoute());
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    imageButton: 'assets/images/elements/game-section.png',
                    onTap: () {
                      context.router.push(GameSelectionRoute());
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    imageButton: 'assets/images/elements/settings.png',
                    onTap: () {
                      context.router.push(SettingsRoute());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
