import 'voice_avatar.dart';

class RunZone {
  static const int minSafeHR = 120;
  static const int maxSafeHR = 150;
  static const double maxPace = 8.0; // min/km
  static const Duration sessionGoalTime = Duration(minutes: 40);
}

class AvatarCoach {
  final VoiceAvatar voice;

  AvatarCoach(this.voice);

  void evaluate({
    required int heartRate,
    required double pace,
    required Duration elapsedTime,
  }) {
    if (heartRate > RunZone.maxSafeHR) {
      voice.speak("Your heart rate is too high. Slow down.");
    } else if (heartRate < RunZone.minSafeHR || pace > RunZone.maxPace) {
      voice.speak("Let’s pick up the pace. You're below your zone.");
    } else if (elapsedTime >= RunZone.sessionGoalTime) {
      voice.speak("Session goal reached. Great job!");
    } else {
      voice.speak("Perfect rhythm. Stay in the zone.");
    }
  }
}
