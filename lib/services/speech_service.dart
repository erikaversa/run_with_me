import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  Future<void> init() async {
    _isAvailable = await _speech.initialize();
  }

  Future<void> listen(Function(String) onResult) async {
    if (!_isAvailable) return;
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      localeId: 'en_US',
    );
  }

  void stop() => _speech.stop();
  void cancel() => _speech.cancel();
}
