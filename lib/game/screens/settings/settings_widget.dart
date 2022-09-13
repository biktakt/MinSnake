import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake/game/hive_box.dart';
import 'package:snake/game/screens/settings/settings_widget_model.dart';
import 'package:snake/widgets/bottom_app_bar_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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
        });
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appLocalizations.toggleTheme),
                IconButton(
                    onPressed: () => settings.toggleTheme(),
                    icon: const Icon(Icons.brightness_4)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: showClearLeaderboardDialog,
              child: Text(appLocalizations.clearLeaderboard),
            ),
          ]),
      bottomNavigationBar: BottomAppBarButton(
        text: Text(AppLocalizations.of(context).mainMenu),
        onPressed: exitToMenu,
      ),
    );
  }
}
