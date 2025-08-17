import 'package:flutter/material.dart';
import 'package:run_with_me_voice/voice_avatar.dart';
import '../services/ask_aion.dart';

class AskAionButton extends StatefulWidget {
  final VoiceAvatar avatar;
  const AskAionButton({super.key, required this.avatar});

  @override
  State<AskAionButton> createState() => _AskAionButtonState();
}

class _AskAionButtonState extends State<AskAionButton> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _askAion() async {
    setState(() => _loading = true);
    await askAionAndSpeak(_controller.text, widget.avatar);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Ask Aion'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _loading ? null : _askAion,
          child:
              _loading ? const CircularProgressIndicator() : const Text('Ask'),
        ),
      ],
    );
  }
}
