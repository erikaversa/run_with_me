import 'package:flutter_tts/flutter_tts.dart';

class VoiceAvatar {
  final FlutterTts _tts = FlutterTts();

  VoiceAvatar() {
    _tts.setLanguage("en-US");
    _tts.setPitch(1.1); // Slightly higher for a more natural female sound
    _tts.setSpeechRate(0.5);
    _setFemaleVoice();
  }

  Future<void> _setFemaleVoice() async {
    final voices = await _tts.getVoices;
    // Try to find a US English female voice
    final femaleVoice = voices.firstWhere(
      (v) =>
          (v['locale'] == 'en-US' || v['locale'] == 'en_US') &&
          (v['name']?.toLowerCase().contains('female') ?? false),
      orElse: () => voices.isNotEmpty ? voices.first : null,
    );
    if (femaleVoice != null) {
      await _tts.setVoice(femaleVoice);
    }
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
