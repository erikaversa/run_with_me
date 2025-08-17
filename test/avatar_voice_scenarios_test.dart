import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:run_with_me_voice/avatar_voice.dart';

class ConsoleVoiceAvatar extends AvatarVoice {
  @override
  Future<void> speak(String text) async {
    if (kDebugMode) {
      debugPrint('Avatar says: $text');
    }
  }

  @override
  Future<void> stop() async {
    if (kDebugMode) {
      debugPrint('Avatar stopped speaking');
    }
  }
}

void main() {
  final scenarios = [
    {
      'desc': 'Motivational message',
      'text': 'Keep going! You are doing great!'
    },
    {
      'desc': 'Warning message',
      'text': 'Please slow down, your heart rate is high.'
    },
    {
      'desc': 'Speed up message',
      'text': 'You can pick up the pace if you are feeling good.'
    },
    {
      'desc': 'General advice',
      'text': 'Remember to stay hydrated and listen to your body.'
    },
    {
      'desc': 'End of run',
      'text': 'Great job on your run! You covered 5 kilometers!'
    },
  ];

  test('AvatarVoice speaks different scenario phrases', () async {
    final avatar = ConsoleVoiceAvatar();
    for (var scenario in scenarios) {
      debugPrint('--- ${scenario['desc']} ---');
      await avatar.speak(scenario['text'] as String);
      await avatar.stop();
    }
  });
}
