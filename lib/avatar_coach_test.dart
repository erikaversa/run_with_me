import 'package:flutter/material.dart';
import 'widgets/avatar_coach.dart';

void main() => runApp(const AvatarCoachTestApp());

class AvatarCoachTestApp extends StatelessWidget {
  const AvatarCoachTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AvatarCoachTestPage(),
    );
  }
}

class AvatarCoachTestPage extends StatelessWidget {
  const AvatarCoachTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarCoach = AvatarCoach();
    final simulatedStatus = avatarCoach.evaluate(
      heartRate: 142,
      pace: 7.1,
      elapsedTime: const Duration(minutes: 25),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Avatar Coach Test')),
      body: Center(
        child: AvatarWidget(status: simulatedStatus),
      ),
    );
  }
}
