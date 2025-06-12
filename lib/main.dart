import 'package:flutter/material.dart';
import 'widgets/health_status_card.dart';
import 'services/voice_service.dart';

void main() => runApp(const RunWithMeApp());

class RunWithMeApp extends StatelessWidget {
  const RunWithMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Run With Me', home: RunHomePage());
  }
}

class RunHomePage extends StatefulWidget {
  const RunHomePage({super.key});

  @override
  State<RunHomePage> createState() => _RunHomePageState();
}

class _RunHomePageState extends State<RunHomePage> {
  final VoiceService voice = VoiceService();
  bool isRunning = false;
  bool isPaused = false;
  Duration runDuration = Duration.zero;
  double distanceKm = 0.0;
  double pace = 6.0; // min/km
  String goal = '5K';
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _ticker = Ticker(_onTick);
  }

  void _onTick(Duration elapsed) {
    if (isRunning && !isPaused) {
      setState(() {
        runDuration = elapsed;
        // Simulate distance and pace
        distanceKm = elapsed.inSeconds / 600.0; // ~6 min/km
        pace = distanceKm > 0 ? elapsed.inMinutes / distanceKm : 0.0;
      });
    }
  }

  void _startRun() {
    setState(() {
      isRunning = true;
      isPaused = false;
      runDuration = Duration.zero;
      distanceKm = 0.0;
      _stopwatch.reset();
      _stopwatch.start();
      _ticker.start();
    });
  }

  void _pauseRun() {
    setState(() {
      isPaused = true;
      _stopwatch.stop();
      _ticker.stop();
    });
  }

  void _resumeRun() {
    setState(() {
      isPaused = false;
      _stopwatch.start();
      _ticker.start();
    });
  }

  void _stopRun() {
    setState(() {
      isRunning = false;
      isPaused = false;
      _stopwatch.stop();
      _ticker.stop();
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _ticker.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Run With Me')),
      body: Container(
        color: Colors.black, // Set background to black
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Distance, Pace, Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CircleStat(
                  label: 'Distance',
                  value: '${distanceKm.toStringAsFixed(2)} km',
                ),
                _CircleStat(
                  label: 'Pace',
                  value: pace > 0 ? pace.toStringAsFixed(2) + ' min/km' : '--',
                ),
                _CircleStat(label: 'Time', value: _formatDuration(runDuration)),
              ],
            ),
            const SizedBox(height: 24),
            // Goal
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Goal: $goal',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Health Status
            const HealthStatusCard(heartRate: 150, vo2Effort: 80),
            const Spacer(),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CircleButton(
                  icon: Icons.directions_run,
                  label: 'Run',
                  color: Colors.green, // Changed to green
                  onPressed: isRunning ? null : _startRun,
                ),
                // Voice Motivation Button moved here
                _CircleButton(
                  icon: Icons.record_voice_over,
                  label: 'Motivate',
                  color: Colors.deepPurple,
                  onPressed: () {
                    voice.speak(
                      "You are strong! Every step is progress. Keep going!",
                    );
                  },
                ),
                _CircleButton(
                  icon: isPaused ? Icons.play_arrow : Icons.pause,
                  label: isPaused ? 'Resume' : 'Pause',
                  color: Colors.orange,
                  onPressed: isRunning && !isPaused
                      ? _pauseRun
                      : isPaused
                      ? _resumeRun
                      : null,
                ),
                _CircleButton(
                  icon: Icons.stop,
                  label: 'Stop',
                  color: Colors.red,
                  onPressed: isRunning ? _stopRun : null,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class Ticker {
  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _isActive = false;
  late final Stopwatch _sw;
  Ticker(this.onTick) {
    _sw = Stopwatch();
  }
  void start() {
    _isActive = true;
    _sw.start();
    _tick();
  }

  void stop() {
    _isActive = false;
    _sw.stop();
  }

  void reset() {
    _sw.reset();
    _elapsed = Duration.zero;
  }

  void _tick() async {
    while (_isActive) {
      await Future.delayed(const Duration(seconds: 1));
      if (_isActive) {
        _elapsed = _sw.elapsed;
        onTick(_elapsed);
      }
    }
  }

  void dispose() {
    _isActive = false;
    _sw.stop();
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  const _CircleButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: color,
          shape: const CircleBorder(),
          elevation: 6,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox(
              width: 72,
              height: 72,
              child: Icon(icon, color: Colors.white, size: 36),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _CircleStat extends StatelessWidget {
  final String label;
  final String value;
  const _CircleStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.grey[200],
          shape: const CircleBorder(),
          elevation: 4,
          child: Container(
            width: 88,
            height: 88,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
