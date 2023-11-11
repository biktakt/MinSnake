import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/score_board_hive_box.dart';
import '../../widgets/bottom_app_bar_button.dart';

class ScoreBoardWidget extends StatelessWidget {
  const ScoreBoardWidget({super.key});

  List<Widget> getScores() {
    final List<Widget> scores = [];
    final sortedScores = ScoreBoard.getLeaderboard();
    for (var name in sortedScores.keys) {
      scores.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(name)),
              Text(sortedScores[name].toString()),
            ],
          ),
        ),
      );
    }
    return scores;
  }

  @override
  Widget build(BuildContext context) {
    void exitToMenu() {
      Navigator.pop(context);
    }

    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: const Text('ScoreBoard')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
            child: Column(
              children: getScores(),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBarButton(
          text: Text(AppLocalizations.of(context).mainMenu),
          onPressed: exitToMenu,
        ),
      ),
    );
  }
}
