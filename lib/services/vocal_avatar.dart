import 'dart:math';

class VocalAvatar {
  int feedbackScore = 0;
  final Map<String, List<String>> vocab = {
    'start': [
      "Let's begin!",
      "Ready, Erika? Let's run!",
      "Here we go — the journey starts now!"
    ],
    'mid': [
      "You're doing great!",
      "Keep up the pace!",
      "Feel your strength, you're in the flow."
    ],
    'end': [
      "Almost there!",
      "Final push — you've got this!",
      "Cross that finish line with pride!"
    ]
  };

  String choosePhrase(String stage) {
    final options = vocab[stage] ?? ['...'];
    final phrase = options[Random().nextInt(options.length)];

    if (feedbackScore > 5) {
      return "$phrase 🔵 I’m learning fast!";
    } else if (feedbackScore < -3) {
      return "$phrase 🔴 Let me know how to support you better.";
    } else {
      return phrase;
    }
  }

  void updateFeedback(String feedback) {
    if (feedback == 'positive') {
      feedbackScore += 1;
    } else if (feedback == 'negative') {
      feedbackScore -= 2;
    }
  }

  void train(String stage, String newPhrase) {
    if (vocab.containsKey(stage)) {
      vocab[stage]!.add(newPhrase);
    } else {
      vocab[stage] = [newPhrase];
    }
  }
}
