import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:run_with_me_voice/voice_avatar.dart';

class ConsoleVoiceAvatar extends VoiceAvatar {
  @override
  Future<void> speak(String text) async {
    // Only print in debug mode
    if (kDebugMode) {
      debugPrint('Avatar says: $text');
    }
  }
}

void main() {
  test('VoiceAvatar speaks a test phrase', () async {
    final avatar = ConsoleVoiceAvatar();
    await avatar.speak('Hello, this is your running coach!');
    // Check console output for the phrase
  });
}
