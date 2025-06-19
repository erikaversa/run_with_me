import 'dart:convert';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';

class VocalAvatar {
  int feedbackScore;
  Map<String, List<String>> vocab;

  VocalAvatar({
    this.feedbackScore = 0,
    Map<String, List<String>>? vocab,
  }) : vocab = vocab ??
            {
              'start': ["Let's go!", "Ready, Erika? Let's run."],
              'mid': ["You're doing great!", "Keep it steady."],
              'end': ["Almost there!", "Final stretch — fly!"],
            };

  String choosePhrase(String stage) {
    final options = vocab[stage] ?? ['...'];
    final phrase = options[Random().nextInt(options.length)];
    if (feedbackScore > 5) return "$phrase 🔵 You're teaching me well.";
    if (feedbackScore < -3) return "$phrase 🔴 I'm still learning.";
    return phrase;
  }

  void train(String stage, String newPhrase) {
    vocab[stage] = (vocab[stage] ?? [])..add(newPhrase);
  }

  void updateFeedback(String feedback) {
    if (feedback == 'positive') feedbackScore += 1;
    if (feedback == 'negative') feedbackScore -= 2;
  }

  Future<void> save() async {
    final box = Hive.box('avatarBox');
    final data = {
      'feedbackScore': feedbackScore,
      'vocab': vocab.map((k, v) => MapEntry(k, jsonEncode(v))),
    };
    await box.put('vocalAvatar', data);
  }

  static Future<VocalAvatar> load() async {
    final box = Hive.box('avatarBox');
    final data = box.get('vocalAvatar');
    if (data == null) return VocalAvatar();
    final decodedVocab = (data['vocab'] as Map).map(
      (k, v) => MapEntry(k as String, List<String>.from(jsonDecode(v))),
    );
    return VocalAvatar(
      feedbackScore: data['feedbackScore'] ?? 0,
      vocab: decodedVocab,
    );
  }
}
