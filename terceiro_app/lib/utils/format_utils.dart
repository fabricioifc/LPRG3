import 'package:flutter/cupertino.dart';

class FormatUtils {
  static String secondsToFormatedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);

    String minutesFormated =
        roundedMinutes < 10 ? '0$roundedMinutes' : '$roundedMinutes';

    String secondsFormated =
        remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';

    return '$minutesFormated:$secondsFormated';
  }
}
