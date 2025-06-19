import 'package:flutter/material.dart';
import '../run_zone.dart';

/// Avatar mood states for the smart coach.
enum AvatarMood { safe, warning, danger }

/// Status object for the avatar, including mood and message.
class AvatarStatus {
  final AvatarMood mood;
  final String message;

  const AvatarStatus(this.mood, this.message);
}

/// Real-time evaluator for avatar mood and feedback.
class AvatarCoach {
  AvatarStatus evaluate({
    required int heartRate,
    required double pace,
    required Duration elapsedTime,
  }) {
    // Danger: Heart rate too high
    if (heartRate > RunZone.maxSafeHR) {
      return const AvatarStatus(
        AvatarMood.danger,
        "Slow down, your heart rate is too high! 💓",
      );
    }
    // Warning: Below minimum effort
    if (heartRate < RunZone.minSafeHR || pace > RunZone.maxPace) {
      return const AvatarStatus(
        AvatarMood.warning,
        "Let’s pick it up a little. You’re below your training zone! 🐢",
      );
    }
    // Safe: Goal reached
    if (elapsedTime >= RunZone.sessionGoalTime) {
      return const AvatarStatus(
        AvatarMood.safe,
        "Goal reached! Amazing work! 🎯",
      );
    }
    // Safe: In the zone
    return const AvatarStatus(
      AvatarMood.safe,
      "Perfect pace! Keep going. You're right on track. 🚀",
    );
  }
}

/// UI widget for displaying the avatar and its message.
class AvatarWidget extends StatelessWidget {
  final AvatarStatus status;

  const AvatarWidget({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    String avatarImage;
    switch (status.mood) {
      case AvatarMood.safe:
        avatarImage = 'assets/avatar_happy.png';
        break;
      case AvatarMood.warning:
        avatarImage = 'assets/avatar_neutral.png';
        break;
      case AvatarMood.danger:
        avatarImage = 'assets/avatar_concerned.png';
        break;
    }
    return Column(
      children: [
        Image.asset(avatarImage, height: 120),
        const SizedBox(height: 10),
        Text(
          status.message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
