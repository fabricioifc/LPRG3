import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:terceiro_app/models/pomodoro_status.dart';
import 'package:terceiro_app/providers/dark_theme_provider.dart';
import 'package:terceiro_app/utils/constants.dart';
import 'package:terceiro_app/utils/format_utils.dart';
import 'package:terceiro_app/widgets/custom_buttom.dart';
import 'package:terceiro_app/widgets/progress-icons.dart';

const _btnTextStart = 'INICIAR';
const _btnTextResume = 'CONTINUAR';
const _btnTextResumeBreak = 'CONTINUAR';
const _btnTextStartShortBreak = 'PAUSA CURTA';
const _btnTextStartLongBreak = 'PAUSA LONGA';
const _btnTextStartNew = 'INICIAR NOVO';
const _btnTextPause = 'PAUSE';
const _btnTextReset = 'REINICIAR';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _remainingTime = pomodoroTotalTime;
  String _btnText = _btnTextStart;
  PomodoroStatus pomodoroStatus = PomodoroStatus.paused;
  Timer? _timer;
  int _pomodoroNum = 0;
  int _setNum = 0;

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Método Pomodoro | Timer'),
        actions: [
          Switch.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: themeProvider.alterarTema)
        ],
      ),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            _sizedBox(),
            _titleScreen(
              // bgColor: Theme.of(context).primaryColor,
              text: 'Método Pomodoro',
            ),
            _sizedBox(),
            Text(
              statusDescription[pomodoroStatus].toString(),
              // style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            _sizedBox(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularIndicator(
                  text: FormatUtils.secondsToFormatedString(_remainingTime),
                ),
                _sizedBox(),
                ProgressIcons(
                  total: pomodoroPerSet,
                  done: _pomodoroNum - (_setNum * pomodoroPerSet),
                ),
                _sizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButtom(
                      onClick: _mainButtonPressed,
                      text: _btnText,
                    ),
                    CustomButtom(
                      onClick: _resetButtonPressed,
                      text: _btnTextReset,
                    ),
                  ],
                )
              ],
            ))
          ])),
    );
  }

  Widget _circularIndicator({required String text}) {
    return CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 12.0,
      percent: _getPomodoroPercent(),
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        text,
        style: TextStyle(fontSize: 40.0),
      ),
      progressColor: statusColor[pomodoroStatus],
    );
  }

  Widget _sizedBox() {
    return const SizedBox(
      height: 10.0,
    );
  }

  Widget _titleScreen({required String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 32.0),
    );
  }

  _mainButtonPressed() {
    debugPrint('$pomodoroStatus');
    switch (pomodoroStatus) {
      case PomodoroStatus.paused:
        _startPomodoroCountDown();
        break;
      case PomodoroStatus.running:
        _pausePomodoroCountDown();
        break;
      case PomodoroStatus.runningShortBreak:
        _pauseShortBreakCountDown();
        break;
      case PomodoroStatus.pausedShortBreak:
        _startShortBreakCountDown();
        break;
      case PomodoroStatus.runningLongBreak:
        _pauseLongBreakCountDown();
        break;
      case PomodoroStatus.pausedLongBreak:
        _startLongBreakCountDown();
        break;
      case PomodoroStatus.setFinished:
        _setNum++;
        _startPomodoroCountDown();
        break;
      default:
    }
  }

  _pauseShortBreakCountDown() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pauseBreakCountDown();
  }

  _pauseLongBreakCountDown() {
    pomodoroStatus = PomodoroStatus.pausedLongBreak;
    _pauseBreakCountDown();
  }

  void _startPomodoroCountDown() {
    pomodoroStatus = PomodoroStatus.running;
    _cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _btnText = _btnTextPause;
        });
      } else {
        _playSound();
        _pomodoroNum++;
        _cancel();

        if (_pomodoroNum % pomodoroPerSet == 0) {
          pomodoroStatus = PomodoroStatus.pausedLongBreak;
          setState(() {
            _remainingTime = longBreakTime;
            _btnText = _btnTextStartLongBreak;
          });
        } else {
          pomodoroStatus = PomodoroStatus.pausedShortBreak;
          setState(() {
            _remainingTime = shortBreakTime;
            _btnText = _btnTextStartShortBreak;
          });
        }
      }
    });
  }

  _pausePomodoroCountDown() {
    pomodoroStatus = PomodoroStatus.paused;
    _cancel();
    setState(() {
      _btnText = _btnTextResume;
    });
  }

  _resetButtonPressed() {
    _pomodoroNum = 0;
    _setNum = 0;
    _cancel();
    _stopCountDown();
  }

  void _stopCountDown() {
    pomodoroStatus = PomodoroStatus.paused;
    setState(() {
      _btnText = _btnTextStart;
      _remainingTime = pomodoroTotalTime;
    });
  }

  void _cancel() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  _getPomodoroPercent() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.pausedLongBreak:
      case PomodoroStatus.runningLongBreak:
        totalTime = longBreakTime;
        break;

      case PomodoroStatus.pausedShortBreak:
      case PomodoroStatus.runningShortBreak:
        totalTime = shortBreakTime;
        break;
      default:
        totalTime = pomodoroTotalTime;
        break;
    }

    double percent = (totalTime - _remainingTime) / totalTime;
    return percent;
  }

  void _pauseBreakCountDown() {
    _cancel();
    setState(() {
      _btnText = _btnTextResume;
    });
  }

  void _startShortBreakCountDown() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    setState(() {
      _btnText = _btnTextPause;
    });
    _cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _playSound();
        _remainingTime = pomodoroTotalTime;
        _cancel();
        pomodoroStatus = PomodoroStatus.paused;
        setState(() {
          _btnText = _btnTextResumeBreak;
        });
      }
    });
  }

  void _startLongBreakCountDown() {
    pomodoroStatus = PomodoroStatus.runningLongBreak;
    setState(() {
      _btnText = _btnTextPause;
    });
    _cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _playSound();
        _remainingTime = pomodoroTotalTime;
        _cancel();
        pomodoroStatus = PomodoroStatus.setFinished;
        setState(() {
          _btnText = _btnTextStartNew;
        });
      }
    });
  }

  void _playSound() {
    FlutterBeep.beep();
  }
}
