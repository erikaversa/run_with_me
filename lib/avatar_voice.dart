import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

/// Abstract base for avatar voice logic
abstract class AvatarVoice {
  Future<void> speak(String text);
  Future<void> stop();
}

/// Default implementation using flutter_tts
class TtsAvatarVoice extends AvatarVoice {
  final FlutterTts _tts = FlutterTts();

  // Call this after constructing the object to initialize voice settings
  Future<void> init({String gender = 'female'}) async {
    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.1); // Slightly higher for a more natural female sound
    await _tts.setSpeechRate(0.5);
    await setVoice(gender);
  }

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  // Public method to change voice gender at runtime
  Future<void> setVoice(String gender) async {
    try {
      final voices = await _tts.getVoices;
      final selectedVoice = voices.firstWhere(
        (v) =>
            (v['locale'] == 'en-US' || v['locale'] == 'en_US') &&
            (v['name']?.toLowerCase().contains(gender) ?? false),
        orElse: () => voices.isNotEmpty ? voices.first : null,
      );
      if (selectedVoice != null) {
        await _tts.setVoice(selectedVoice);
        debugPrint('Set $gender voice: \\${selectedVoice['name']}');
      } else {
        debugPrint('No $gender voice found, using default voice.');
      }
    } catch (e) {
      debugPrint('Error setting $gender voice: $e');
    }
  }
}
