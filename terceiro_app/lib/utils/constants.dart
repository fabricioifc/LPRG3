import 'package:flutter/material.dart';
import 'package:terceiro_app/models/pomodoro_status.dart';

const pomodoroTotalTime = 25 /** 60*/;
const shortBreakTime = 5 /** 60*/;
const longBreakTime = 15 /** 60*/;
const pomodoroPerSet = 3;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.running: 'Pomodoro está em execução...',
  PomodoroStatus.paused: 'Está pronto para focar nos estudos?',
  PomodoroStatus.runningShortBreak: 'Pausa curta para relaxar...',
  PomodoroStatus.pausedShortBreak: 'Vamos dar uma pausa curta nos estudos?',
  PomodoroStatus.runningLongBreak: 'Pausa para relaxar... Tome um cafezinho...',
  PomodoroStatus.pausedLongBreak: 'Vamos dar uma pausa nos estudos?',
  PomodoroStatus.setFinished:
      'A folga terminou... Vamos focar nos estudos novamente?',
};

const Map<PomodoroStatus, Color> statusColor = {
  PomodoroStatus.running: Colors.amber,
  PomodoroStatus.paused: Colors.orange,
  PomodoroStatus.runningShortBreak: Colors.red,
  PomodoroStatus.pausedShortBreak: Colors.orange,
  PomodoroStatus.runningLongBreak: Colors.red,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.setFinished: Colors.orange,
};
