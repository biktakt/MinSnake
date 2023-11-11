import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'game/screens/game.dart';
import 'game/screens/main_menu.dart';
import 'game/screens/score_board_widget.dart';
import 'game/screens/settings/settings_widget.dart';
import 'game/screens/settings/settings_widget_model.dart';
import 'theme/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('scoreBoard');
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsWidgetModel(),
      child: const RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: context.select((SettingsWidgetModel m) => m.currentTheme),
      routes: {
        '/': (context) => const MainMenu(),
        '/game': (context) => const SnakeGame(),
        '/score_board': (context) => const ScoreBoardWidget(),
        '/settings': (context) => const Settings(),
      },
      initialRoute: '/',
    );
  }
}
