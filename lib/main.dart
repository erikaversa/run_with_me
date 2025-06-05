import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const RunWithMeApp());
}

/// Main App widget setting up theme and home page
class RunWithMeApp extends StatelessWidget {
  const RunWithMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run With Me',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const RunHomePage(),
    );
  }
}

/// Home page StatefulWidget to manage run state
class RunHomePage extends StatefulWidget {
  const RunHomePage({super.key});

  @override
  State<RunHomePage> createState() => _RunHomePageState();
}

class _RunHomePageState extends State<RunHomePage> {
  // Whether the run is active
  bool isRunning = false;

  // Duration of the current run
  Duration runDuration = Duration.zero;

  // Distance covered in km (mocked for now)
  double distanceKm = 0.0;

  // Whether audio coaching is playing
  bool isAudioPlaying = false;

  // Timer for updating run duration and distance every second
  Timer? _timer;

  /// Starts the run: resets timer, distance and starts timer updates
  void _startRun() {
    setState(() {
      isRunning = true;
      runDuration = Duration.zero;
      distanceKm = 0.0;
      isAudioPlaying = true; // Start coaching audio
    });

    // Timer tick every 1 second: update duration and mock distance
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        runDuration += const Duration(seconds: 1);

        // Simulate distance covered, e.g., 10 km/h = 2.78 m/s ~ 0.00278 km/s
        // Adjust or replace with real GPS tracking later
        distanceKm += 0.00278;
      });
    });
  }

  /// Stops the run and the timer, pauses audio coaching
  void _stopRun() {
    setState(() {
      isRunning = false;
      isAudioPlaying = false;
    });
    _timer?.cancel();
  }

  /// Toggles audio coaching play/pause
  void _toggleAudio() {
    if (!isRunning) return; // No audio controls if not running

    setState(() {
      isAudioPlaying = !isAudioPlaying;
    });

    // TODO: Integrate actual audio play/pause functionality here
  }

  /// Formats a Duration as hh:mm:ss or mm:ss string
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up timer on widget disposal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate pace: minutes per km
    final pace = distanceKm > 0 && runDuration.inSeconds > 0
        ? (runDuration.inSeconds / 60) / distanceKm
        : 0;

    // Example pace goal for coloring (6 min/km)
    const double paceGoal = 6.0;

    // Determine color based on pace vs goal
    Color paceColor;
    if (!isRunning) {
      paceColor = Colors.grey;
    } else if (pace == 0) {
      paceColor = Colors.blueAccent;
    } else if (pace <= paceGoal) {
      paceColor = Colors.green;
    } else {
      paceColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Run With Me - Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top row with three colored stat cards
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.timer,
                      label: 'Time',
                      value: _formatDuration(runDuration),
                      color: Colors.deepPurple.shade300,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.directions_run,
                      label: 'Distance',
                      value: '${distanceKm.toStringAsFixed(2)} km',
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.speed,
                      label: 'Pace',
                      value: pace > 0 ? '${pace.toStringAsFixed(2)} min/km' : '--',
                      color: paceColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Pace progress bar showing performance against goal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pace Goal: $paceGoal min/km',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: isRunning && pace > 0
                      ? (pace <= paceGoal ? 1 - (pace / paceGoal) : 0)
                      : 0,
                  minHeight: 14,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation(paceColor),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Big start/stop button, color changes based on running state
            ElevatedButton.icon(
              onPressed: isRunning ? _stopRun : _startRun,
              icon: Icon(isRunning ? Icons.stop : Icons.play_arrow),
              label: Text(isRunning ? 'Stop Run' : 'Start Run'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                backgroundColor: isRunning ? Colors.redAccent : Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // Audio coaching controls: play/pause button + label
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  icon: Icon(isAudioPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill),
                  color: Theme.of(context).primaryColor,
                  onPressed: isRunning ? _toggleAudio : null,
                ),
                const SizedBox(width: 12),
                Text(
                  isAudioPlaying ? 'Coaching On' : 'Coaching Paused',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A colored card widget showing an icon, a label, and a value (e.g. Time, Distance)
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.85),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
