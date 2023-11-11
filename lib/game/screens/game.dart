import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/grid.dart';
import '../../models/point.dart';
import '../../resources/app_images.dart';
import '../../services/score_board_hive_box.dart';
import '../../theme/colors.dart';
import '../snake.dart';
import 'pause_menu.dart';
import 'settings/settings_widget_model.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  Snake snake = Snake.randomSpawn();
  int get score => snake.body.length - 3;

  late Timer timer;
  TextEditingController playerNameController = TextEditingController();
  final FocusNode _gridFocusNode = FocusNode();
  // TODO: Change the image substitution method
  late final bool isDepecheMode;

  List<Tile> getGrid() {
    Color? color;
    AssetImage? image;
    final List<Tile> grids = [];
    PointTile pointTile;
    for (int i = 0; i < Grid.height; i++) {
      for (int j = 0; j < Grid.width; j++) {
        pointTile = PointTile(j, i);
        if (snake.body.contains(pointTile)) {
          if (snake.body[0] == pointTile) {
            color = Theme.of(context).colorScheme.snakeHead;
            image = AppImages.depecheMembers[snake.body.indexOf(pointTile) %
                AppImages.depecheMembers.length];
          } else {
            color = Theme.of(context).colorScheme.snake;
            image = AppImages.depecheMembers[snake.body.indexOf(pointTile) %
                AppImages.depecheMembers.length];
          }
        } else if (snake.food == pointTile) {
          color = Theme.of(context).colorScheme.food;
          image = AppImages.depecheInstrumental[
              snake.body.length % AppImages.depecheInstrumental.length];
        } else {
          color = Theme.of(context).colorScheme.tileColor;
          image = null;
        }
        image = isDepecheMode ? image : null;
        grids.add(Tile(color, image));
      }
    }
    return grids;
  }

  void onTimer() {
    if (!snake.moveSnake()) {
      timer.cancel();
      showGameOverScreen();
    }
    setState(() {});
  }

  void gameStart() {
    final tickRate = Duration(milliseconds: 200 - snake.speed);
    timer = Timer.periodic(tickRate, (timer) => onTimer());
  }

  void restart() {
    snake = Snake.randomSpawn();
    gameStart();
  }

  void onPlayAgain() {
    if (playerNameController.text != '') {
      ScoreBoard.addNewRecord(playerNameController.text, score);
    }
    restart();
    Navigator.of(context).pop();
  }

  void onExitToMenu() {
    if (playerNameController.text != '') {
      ScoreBoard.addNewRecord(playerNameController.text, score);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<bool> gameOverOnWillPopScope() async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    return Future.value(false);
  }

  void showGameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: gameOverOnWillPopScope,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context).gameOver),
            content: Text('${AppLocalizations.of(context).score}: $score'),
            actions: <Widget>[
              TextField(
                maxLength: 20,
                controller: playerNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).enterName,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: onExitToMenu,
                    child: Text(AppLocalizations.of(context).mainMenu),
                  ),
                  TextButton(
                    onPressed: onPlayAgain,
                    child: Text(AppLocalizations.of(context).playAgain),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleKeyEvent(RawKeyEvent event) {
    snake.changeDirectionPress(event.logicalKey);
    setState(() {});
  }

  @override
  void initState() {
    final SettingsWidgetModel settingsModel =
        context.read<SettingsWidgetModel>();
    snake = Snake.randomSpawn();
    isDepecheMode = settingsModel.depecheMode;
    super.initState();
    gameStart();
  }

  Future<bool> pauseGame() async {
    timer.cancel();
    final result = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => const PauseMenu(),
      ),
    );
    if (result != null) gameStart();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pauseGame,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20,
                    right: 20,
                    bottom: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppLocalizations.of(context).score}: $score',
                      ),
                      GestureDetector(
                        onTap: pauseGame,
                        child: const Icon(Icons.pause_rounded),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: RawKeyboardListener(
                    focusNode: _gridFocusNode,
                    onKey: _handleKeyEvent,
                    child: GestureDetector(
                      onVerticalDragUpdate: snake.changeDirectionSwipe,
                      onHorizontalDragUpdate: snake.changeDirectionSwipe,
                      child: GridView.count(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: Grid.width,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: getGrid(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Color? color;
  final AssetImage? image;
  const Tile(this.color, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          image: _checkImage(image),
        ),
      ),
    );
  }

  static DecorationImage? _checkImage(AssetImage? image) {
    if (image != null) {
      return DecorationImage(
        image: image,
        fit: BoxFit.cover,
      );
    }
    return null;
  }
}
