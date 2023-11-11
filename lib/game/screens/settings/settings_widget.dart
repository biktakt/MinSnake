import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../services/score_board_hive_box.dart';
import '../../../widgets/bottom_app_bar_button.dart';
import 'settings_widget_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void showClearLeaderboardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final appLocalizations = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(appLocalizations.clearLeaderboard_alert_title),
          content: Text(appLocalizations.clearLeaderboard_alert_text),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.clearLeaderboard_alert_cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScoreBoard.clear();
              },
              child: Text(appLocalizations.clearLeaderboard_alert_yes),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final settings = context.read<SettingsWidgetModel>();

    void exitToMenu() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appLocalizations.toggleTheme),
              IconButton(
                onPressed: () => settings.toggleTheme(),
                icon: const Icon(Icons.brightness_4),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appLocalizations.depecheMode),
              Switch(
                value: context.select((SettingsWidgetModel m) => m.depecheMode),
                onChanged: (_) => settings.toggleDepecheMode(),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: showClearLeaderboardDialog,
            child: Text(appLocalizations.clearLeaderboard),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarButton(
        text: Text(AppLocalizations.of(context).mainMenu),
        onPressed: exitToMenu,
      ),
    );
  }
}
