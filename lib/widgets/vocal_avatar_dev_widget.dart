import 'package:flutter/material.dart';
import '../services/vocal_avatar.dart';
import '../services/voice_service.dart';

class VocalAvatarDevWidget extends StatefulWidget {
  const VocalAvatarDevWidget({super.key});
  @override
  State<VocalAvatarDevWidget> createState() => _VocalAvatarDevWidgetState();
}

class _VocalAvatarDevWidgetState extends State<VocalAvatarDevWidget> {
  final VoiceService voice = VoiceService();
  final VocalAvatar avatar = VocalAvatar();

  String selectedStage = 'start';
  String newPhrase = '';
  String lastSpoken = '';

  void speakStage() async {
    final phrase = avatar.choosePhrase(selectedStage);
    setState(() => lastSpoken = phrase);
    await voice.speak(phrase);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🎙️ Avatar Trainer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        DropdownButton<String>(
          value: selectedStage,
          onChanged: (value) {
            if (value != null) setState(() => selectedStage = value);
          },
          items: ['start', 'mid', 'end']
              .map((stage) =>
                  DropdownMenuItem(value: stage, child: Text("Stage: $stage")))
              .toList(),
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Add new phrase"),
          onChanged: (value) => newPhrase = value,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                avatar.train(selectedStage, newPhrase);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Phrase added.")));
              },
              child: const Text("➕ Train"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: speakStage,
              child: const Text("▶️ Test Voice"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                avatar.updateFeedback('positive');
                setState(() {});
              },
              child: const Text("👍 Positive"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                avatar.updateFeedback('negative');
                setState(() {});
              },
              child: const Text("👎 Negative"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("🧠 Feedback Score: ",
            style: TextStyle(fontWeight: FontWeight.w500)),
        Text("${avatar.feedbackScore}"),
        const SizedBox(height: 10),
        if (lastSpoken.isNotEmpty)
          Text("🔊 Last Spoken: \"$lastSpoken\"",
              style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }
}
