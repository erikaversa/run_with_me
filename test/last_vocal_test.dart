import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:run_with_me_voice/avatar_coach.dart';
import 'package:run_with_me_voice/avatar_voice.dart';

class ConsoleVoiceAvatar extends TtsAvatarVoice {
  @override
  Future<void> speak(String text) async {
    if (kDebugMode) {
      debugPrint('Avatar says: $text');
    }
  }
}

void main() {
  test('AvatarCoach gives correct feedback for various scenarios', () async {
    final voice = ConsoleVoiceAvatar();
    final coach = AvatarCoach(voice);

    final testCases = [
      {
        'desc': 'Below safe zone',
        'hr': 110,
        'pace': 7.0,
        'elapsed': const Duration(minutes: 10)
      },
      {
        'desc': 'In safe zone, good pace',
        'hr': 130,
        'pace': 6.5,
        'elapsed': const Duration(minutes: 20)
      },
      {
        'desc': 'Above safe zone',
        'hr': 155,
        'pace': 6.0,
        'elapsed': const Duration(minutes: 15)
      },
      {
        'desc': 'Too slow, in safe HR',
        'hr': 135,
        'pace': 9.0,
        'elapsed': const Duration(minutes: 25)
      },
      {
        'desc': 'Goal reached',
        'hr': 140,
        'pace': 7.0,
        'elapsed': const Duration(minutes: 40)
      },
    ];

    for (var test in testCases) {
      if (kDebugMode) {
        debugPrint('--- ${test['desc']} ---');
      }
      await coach.evaluate(
        heartRate: test['hr'] as int,
        pace: test['pace'] as double,
        elapsedTime: test['elapsed'] as Duration,
      );
    }
  });
}
