import 'package:hive/hive.dart';

class ScoreBoard {
  static final Box<int> _box = Hive.box<int>('scoreBoard');

  static void addNewRecord(String name, int score) async {
    if (_box.containsKey(name)) {
      final oldSrore = _box.get(name) ?? 0;
      if (score > oldSrore) {
        await _box.put(name, score);
      }
    } else {
      await _box.put(name, score);
    }
  }

  static void clear() {
    _box.clear();
  }

  static Map<dynamic, int> getLeaderboard() {
    final dict = _box.toMap();
    final sortedValuesDesc = Map<dynamic, int>.fromEntries(
        dict.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
    return sortedValuesDesc;
  }
}
