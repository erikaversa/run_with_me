import 'package:flutter_tts/flutter_tts.dart';

/// Abstract base for avatar voice logic
abstract class AvatarVoice {
  Future<void> speak(String text);
  Future<void> stop();
}

/// Default implementation using flutter_tts
class TtsAvatarVoice extends AvatarVoice {
  final FlutterTts _tts = FlutterTts();

  TtsAvatarVoice() {
    _tts.setLanguage("en-US");
    _tts.setPitch(1.1); // Slightly higher for a more natural female sound
    _tts.setSpeechRate(0.5);
    _setVoice('male');
  }

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> _setVoice(String gender) async {
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
      } else {
        // Log or handle no matching voice found
        print('No $gender voice found, using default voice.');
      }
    } catch (e) {
      print('Error setting $gender voice: $e');
    }
  }
}
