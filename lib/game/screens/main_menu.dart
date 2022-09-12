import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:snake/theme/custom_theme.dart';
import 'package:snake/widgets/menu_button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    void startGame() {
      Navigator.pushNamed(context, '/game');
    }

    void openScoreBoard() {
      Navigator.pushNamed(context, '/score_board');
    }

    void openSettings() {
      Navigator.pushNamed(context, '/settings');
    }

    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          AppLocalizations.of(context).snake,
          style: CustomTheme.logoTextStyle,
        ),
        const SizedBox(height: 30),
        MenuButton(
          text: Text(appLocalizations.play.toUpperCase()),
          onPressed: startGame,
        ),
        const SizedBox(height: 10),
        MenuButton(
          text: Text(appLocalizations.leaderboard.toUpperCase()),
          onPressed: openScoreBoard,
        ),
        const SizedBox(height: 10),
        MenuButton(
          text: Text(appLocalizations.settings.toUpperCase()),
          onPressed: openSettings,
        ),
      ]),
    ));
  }
}
