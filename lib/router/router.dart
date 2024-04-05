import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_game/find_pairs_game_screen.dart';
import 'package:sweet_bonanza_app/screens/find_pairs/find_pairs_levels/find_pairs_levels_screen.dart';
import 'package:sweet_bonanza_app/screens/game_selection/game_selection_screen.dart';
import 'package:sweet_bonanza_app/screens/main/main_screen.dart';
import 'package:sweet_bonanza_app/screens/puzzle/puzzle_game/puzzle_game_screen.dart';
import 'package:sweet_bonanza_app/screens/puzzle/puzzle_list/puzzle_list_screen.dart';
import 'package:sweet_bonanza_app/screens/settings/settings_screen.dart';
import 'package:sweet_bonanza_app/models/puzzle_model.dart';
import 'package:sweet_bonanza_app/models/level_model.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: GameSelectionRoute.page),
    AutoRoute(page: PuzzleListRoute.page),
    AutoRoute(page: PuzzleGameRoute.page),
    AutoRoute(page: FindPairsLevelsRoute.page),
    AutoRoute(page: FindPairsGameRoute.page),
  ];
}
