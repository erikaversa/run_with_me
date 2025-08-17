import 'package:flutter/material.dart';
import 'package:run_with_me_voice/voice_avatar.dart';

class AvatarVoiceTestWidget extends StatefulWidget {
  const AvatarVoiceTestWidget({super.key});

  @override
  State<AvatarVoiceTestWidget> createState() => _AvatarVoiceTestWidgetState();
}

class _AvatarVoiceTestWidgetState extends State<AvatarVoiceTestWidget> {
  final VoiceAvatar avatar = VoiceAvatar();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _speak() {
    avatar.speak(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Enter text to speak'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _speak,
          child: const Text('Speak'),
        ),
      ],
    );
  }
}
