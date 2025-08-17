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
    _setFemaleVoice();
  }

  Future<void> _setFemaleVoice() async {
    try {
      final voices = await _tts.getVoices;
      final femaleVoice = voices.firstWhere(
        (v) =>
            (v['locale'] == 'en-US' || v['locale'] == 'en_US') &&
            (v['name']?.toLowerCase().contains('female') ?? false),
        orElse: () => voices.isNotEmpty ? voices.first : null,
      );
      if (femaleVoice != null) {
        await _tts.setVoice(femaleVoice);
      } else {
        // Log or handle no female voice found
        print('No female voice found, using default voice.');
      }
    } catch (e) {
      print('Error setting female voice: $e');
    }
  }

  @override
  Future<void> speak(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      print('Error during speak: $e');
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      print('Error during stop: $e');
    }
  }
}
