import 'dart:async';

import 'package:flutter/material.dart';
import 'widgets/health_status_card.dart';

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
      // To change the initial page, update the 'home:' property in MaterialApp.
      // For example, to use a different page:
      // home: const AnotherPage(),
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
  void _toggleAudio() async {
    if (!isRunning) return; // No audio controls if not running

    setState(() {
      isAudioPlaying = !isAudioPlaying;
    });

    // Example: Integrate audio play/pause logic here
    // You could use a package like 'audioplayers' or 'just_audio'
    // For example:
    // if (isAudioPlaying) {
    //   await audioPlayer.resume();
    // } else {
    //   await audioPlayer.pause();
    // }
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
    // Get latest session for display
    final latestSession = testSessions.isNotEmpty ? testSessions.first : null;

    // Calculate pace for latest session
    String pace = '--';
    if (latestSession != null) {
      final distance = (latestSession['distance_km'] ?? 0) is num
          ? (latestSession['distance_km'] as num)
          : 0.0;
      final duration = (latestSession['duration_sec'] ?? 0) is num
          ? (latestSession['duration_sec'] as num)
          : 0.0;
      if (distance > 0) {
        final paceSec = duration / distance;
        final min = (paceSec ~/ 60).toString().padLeft(2, '0');
        final sec = (paceSec % 60).toInt().toString().padLeft(2, '0');
        pace = '$min:$sec min/km';
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDBEAFE), Color(0xFFE9D5FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Main dashboard row
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Data Blocks
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ThreeDButton(
                          onPressed: () {},
                          label: latestSession != null
                              ? '${latestSession['distance_km']} KM'
                              : '-- KM',
                          color: const Color.fromARGB(255, 33, 226, 243),
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 24),
                        ThreeDButton(
                          onPressed: () {},
                          label: latestSession != null
                              ? Duration(
                                  seconds:
                                      (latestSession['duration_sec'] ?? 0)
                                          as int,
                                ).toString().split('.').first
                              : '--:--:--',
                          color: const Color.fromARGB(255, 33, 226, 243),
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 24),
                        ThreeDButton(
                          onPressed: () {},
                          label: pace,
                          color: const Color.fromARGB(255, 33, 226, 243),
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Center Avatar
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 192,
                              height: 192,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF8B5CF6),
                                    Color(0xFF6366F1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurple.withOpacity(0.3),
                                    blurRadius: 24,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'A & E',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Glowing pulse
                            Positioned.fill(
                              child: IgnorePointer(
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Insert HealthStatusCard in the freed space
                        SizedBox(
                          height: 100,
                          child: HealthStatusCard(
                            heartRate: 190,
                            vo2Effort: 82,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Right Side Controls
                  Expanded(
                    flex: 2, // 20% width
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ThreeDButton(
                          onPressed: () {},
                          label: '🏆\n21.1 KM',
                          color: Colors.yellow.shade700,
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 24),
                        ThreeDButton(
                          onPressed: () {},
                          label: '⏸️',
                          color: Colors.red.shade700,
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 24),
                        ThreeDButton(
                          onPressed: () {},
                          label: '🏃',
                          color: Colors.green.shade600,
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Session history (below dashboard)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Session History',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ...testSessions.map((session) {
                    final durationSec = session['duration_sec'];
                    int durationInt = 0;
                    if (durationSec is int) {
                      durationInt = durationSec;
                    } else if (durationSec is double) {
                      durationInt = durationSec.toInt();
                    } else {
                      durationInt = int.tryParse(durationSec.toString()) ?? 0;
                    }
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        '${session['date'] ?? ''} - ${session['distance_km'] ?? ''} km',
                      ),
                      subtitle: Text(
                        'Time: '
                        '${Duration(seconds: durationInt).toString().split('.').first.padLeft(8, "0")}, '
                        'Avg HR: ${session['avg_hr'] ?? ''}',
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A colored card widget showing an icon, a label, and a value (e.g. Time, Distance)
class CircleButton extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  final IconData? icon;

  const CircleButton({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.textColor = Colors.white,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: onPressed,
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, color: textColor, size: 36)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ThreeDButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final double elevation;
  final double borderRadius;
  final EdgeInsets padding;
  final double width;
  final double height;
  final Color textColor;

  const ThreeDButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color = Colors.blue,
    this.elevation = 10.0,
    this.borderRadius = 48.0, // match CircleButton
    this.padding = const EdgeInsets.all(0),
    this.width = 96, // match CircleButton
    this.height = 96, // match CircleButton
    this.textColor = Colors.black, // match CircleButton
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: color,
      elevation: elevation,
      shadowColor: Colors.black87,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 20, // match CircleButton
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              shadows: const [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Test Data for Simulation (converted from JS) ---

const testUser = {
  'id': 'user_12345',
  'email': 'testuser@example.com',
  'name': 'Erika Tester',
};

const testGoal = {
  'distance': 'half-marathon',
  'target_pace': '5:50',
  'notes': 'Prepare for race day',
};

const testSessions = [
  {
    'id': 'sess1',
    'user_id': 'user_12345',
    'date': '2025-06-07',
    'distance_km': 7.2,
    'duration_sec': 2600, // 43:20
    'avg_hr': 152,
  },
  {
    'id': 'sess2',
    'user_id': 'user_12345',
    'date': '2025-06-06',
    'distance_km': 4.5,
    'duration_sec': 1580, // 26:20
    'avg_hr': 140,
  },
  {
    'id': 'sess3',
    'user_id': 'user_12345',
    'date': '2025-06-04',
    'distance_km': 10.1,
    'duration_sec': 3920, // 1:05:20
    'avg_hr': 160,
  },
];

const testHeartRateTrend = {
  'labels': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  'values': [145, 152, 138, 162, 148, 157, 149],
};
