import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snake/widgets/menu_button.dart';

class PauseMenu extends StatefulWidget {
  const PauseMenu({Key? key}) : super(key: key);

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  @override
  void initState() {
    super.initState();
  }

  void resumeGame() {
    Navigator.of(context).pop(true);
  }

  void exitToMenu() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0.60),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MenuButton(
                text: Text(appLocalizations.resume.toUpperCase()),
                onPressed: resumeGame,
              ),
              const SizedBox(height: 10),
              MenuButton(
                text: Text(appLocalizations.mainMenu.toUpperCase()),
                onPressed: exitToMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
