import 'package:flutter/widgets.dart';

abstract class AppImages {
  static const alan = AssetImage('assets/images/depeche_mode/Alan.png');
  static const andy = AssetImage('assets/images/depeche_mode/Andy.png');
  static const dave = AssetImage('assets/images/depeche_mode/Dave.png');
  static const martin = AssetImage('assets/images/depeche_mode/Martin.png');
  static const synthesizer =
      AssetImage('assets/images/depeche_mode/Synthesizer.png');
  static const guitar = AssetImage('assets/images/depeche_mode/Guitar.png');
  static const microphone =
      AssetImage('assets/images/depeche_mode/Microphone.png');

  static const depecheMembers = [alan, dave, martin];
  static const depecheInstrumental = [synthesizer, guitar, microphone];
}
