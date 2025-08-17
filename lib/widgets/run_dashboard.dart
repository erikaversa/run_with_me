import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'stat_card.dart';
import 'health_status_card.dart';

enum RunningState { stopped, running, paused }

class RunDashboard extends StatefulWidget {
  const RunDashboard({super.key});

  @override
  State<RunDashboard> createState() => _RunDashboardState();
}

class _RunDashboardState extends State<RunDashboard> {
  // Running session state
  RunningState _runningState = RunningState.stopped;

  // Metrics
  double _distance = 0.0;
  int _runDurationSeconds = 0;
  double _pace = 6.0;
  int _heartRate = 140;
  Timer? _metricsTimer;
  Timer? _durationTimer;

  // Start running
  void _startRunning() {
    setState(() {
      if (_runningState == RunningState.stopped) {
        _distance = 0.0;
        _runDurationSeconds = 0;
        _pace = 6.0;
        _heartRate = 140;
      }
      _runningState = RunningState.running;
    });
    _startTimers();
  }

  // Pause running
  void _pauseRunning() {
    if (_runningState == RunningState.running) {
      setState(() {
        _runningState = RunningState.paused;
      });
      _stopTimers();
    }
  }

  // Stop running
  void _stopRunning() {
    setState(() {
      _runningState = RunningState.stopped;
    });
    _stopTimers();
  }

  void _startTimers() {
    _metricsTimer?.cancel();
    _durationTimer?.cancel();
    _metricsTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_runningState == RunningState.running) {
        setState(() {
          // Simulate metrics
          _distance += 0.05;
          _pace =
              (_pace + (Random().nextDouble() - 0.5) * 0.2).clamp(4.0, 10.0);
          _heartRate =
              ((_heartRate + Random().nextInt(7) - 3).clamp(120, 180)).toInt();
        });
      }
    });
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_runningState == RunningState.running) {
        setState(() {
          _runDurationSeconds++;
        });
      }
    });
  }

  void _stopTimers() {
    _metricsTimer?.cancel();
    _durationTimer?.cancel();
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _stopTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 📊 Statistiche principali
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatCard(
                label: 'Distanza',
                value: '${_distance.toStringAsFixed(2)} km',
                emoji: '📏'),
            StatCard(
                label: 'Tempo',
                value: _formatDuration(_runDurationSeconds),
                emoji: '⏱️'),
            StatCard(
                label: 'Passo',
                value: '${_pace.toStringAsFixed(2)} /km',
                emoji: '👟'),
          ],
        ),
        const SizedBox(height: 20),
        // ❤️‍🔥 Stato Salute (card compatta)
        HealthStatusCard(
            heartRate: _heartRate, vo2Effort: (_pace * 10).toInt()),
        const SizedBox(height: 30),
        // 🎮 Pulsanti azione
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            ActionButton(
              label:
                  _runningState == RunningState.paused ? 'Riprendi' : 'Start',
              emoji: '🏁',
              onPressed: _runningState == RunningState.stopped ||
                      _runningState == RunningState.paused
                  ? _startRunning
                  : null,
            ),
            ActionButton(
              label: 'Pausa',
              emoji: '⏸️',
              onPressed:
                  _runningState == RunningState.running ? _pauseRunning : null,
            ),
            ActionButton(
              label: 'Stop',
              emoji: '🟥',
              onPressed:
                  _runningState != RunningState.stopped ? _stopRunning : null,
            ),
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final String emoji;
  final VoidCallback? onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.emoji,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 2,
        textStyle: AppText.value.copyWith(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
