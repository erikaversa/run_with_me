import 'package:flutter/material.dart';
import 'package:run_with_me_voice/avatar_voice.dart';
import '../services/ask_aion.dart';

class AskAionButton extends StatefulWidget {
  final TtsAvatarVoice avatar;
  const AskAionButton({super.key, required this.avatar});

  @override
  State<AskAionButton> createState() => _AskAionButtonState();
}

class _AskAionButtonState extends State<AskAionButton> {
  String _lastSpoken = '';
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
    setState(() {
      _lastSpoken = _controller.text;
      _loading = false;
    });
  }

  void _speakCustomText() async {
    setState(() => _loading = true);
    await widget.avatar.speak(_controller.text);
    setState(() {
      _lastSpoken = _controller.text;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Ask or Test Voice'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _loading ? null : _askAion,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Ask Aion'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _loading ? null : _speakCustomText,
                child: const Text('Test Voice'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_lastSpoken.isNotEmpty)
          Text("🔊 Last Spoken: \"$_lastSpoken\"",
              style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }
}
