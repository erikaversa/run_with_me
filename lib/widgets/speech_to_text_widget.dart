import 'package:flutter/material.dart';
import '../services/speech_service.dart';

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key});
  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  final SpeechService _speechService = SpeechService();
  String _lastWords = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechService.init();
  }

  void _startListening() {
    setState(() => _isListening = true);
    _speechService.listen((words) {
      setState(() => _lastWords = words);
    });
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speechService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _isListening ? null : _startListening,
          child: const Text('Start Listening'),
        ),
        ElevatedButton(
          onPressed: _isListening ? _stopListening : null,
          child: const Text('Stop Listening'),
        ),
        const SizedBox(height: 16),
        Text('Heard: $_lastWords'),
      ],
    );
  }
}
