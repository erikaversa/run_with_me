import 'package:flutter_tts/flutter_tts.dart';

class VoiceAvatar {
  final FlutterTts _tts = FlutterTts();

  VoiceAvatar() {
    _tts.setLanguage("en-US");
    _tts.setPitch(1.0);
    _tts.setSpeechRate(0.5); // Calm and clear
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
