import 'dart:async';

import 'package:flutter/material.dart';

class TimerDisplay extends StatefulWidget {
  final String? nextTrainTime;

  const TimerDisplay({super.key, required this.nextTrainTime});

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  String _countdownText = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(TimerDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.nextTrainTime != widget.nextTrainTime) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _updateCountdown();

    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    if (widget.nextTrainTime == null) {
      setState(() {
        _countdownText = 'Нет данных';
      });
      return;
    }

    final now = DateTime.now();
    final timeParts = widget.nextTrainTime!.split(':');
    if (timeParts.length != 2) {
      setState(() {
        _countdownText = 'Неверный формат';
      });
      return;
    }

    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts[1]) ?? 0;

    var trainTime = DateTime(now.year, now.month, now.day, hour, minute);

    // If train time already passed today, use tomorrow's time
    if (trainTime.isBefore(now)) {
      trainTime = trainTime.add(const Duration(days: 1));
    }

    final difference = trainTime.difference(now);
    final totalSeconds = difference.inSeconds;

    if (totalSeconds <= 0) {
      setState(() {
        _countdownText = 'Поезд прибывает';
      });
      return;
    }

    final minutes = (totalSeconds ~/ 60) % 60;
    final seconds = totalSeconds % 60;

    setState(() {
      if (totalSeconds < 60) {
        _countdownText = '$seconds сек';
      } else {
        _countdownText = '$minutes мин ${seconds.toString().padLeft(2, '0')} сек';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _countdownText,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}