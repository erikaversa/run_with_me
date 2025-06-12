import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final FlutterTts _tts = FlutterTts();

  VoiceService() {
    _tts.setLanguage("en-US"); // 👈 English (US)
    _tts.setPitch(1.0);
    _tts.setSpeechRate(0.45); // natural pace for coaching
  }

  Future<void> speak(String text) async {
    await _tts.stop(); // Stop any ongoing speech before starting new
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
