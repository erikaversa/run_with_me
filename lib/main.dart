import 'package:flutter/material.dart';
import 'services/voice_service.dart';

void main() => runApp(const RunWithVoice());

class RunWithVoice extends StatelessWidget {
  const RunWithVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VoiceTestPage(),
    );
  }
}

class VoiceTestPage extends StatefulWidget {
  const VoiceTestPage({super.key});

  @override
  State<VoiceTestPage> createState() => _VoiceTestPageState();
}

class _VoiceTestPageState extends State<VoiceTestPage> {
  final voice = VoiceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voce di Aión')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            voice.speak("Ciao Erika. Hai già fatto il primo passo. Io sono con te.");
          },
          child: const Text('Parla Aión 🗣️'),
        ),
      ),
    );
  }
}
