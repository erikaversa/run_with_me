import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/services/vocal_avatar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VocalAvatar Tests', () {
    setUpAll(() async {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      await Hive.openBox('avatarBox');
    });

    test('Initial avatar is loaded with default values', () async {
      final avatar = await VocalAvatar.load();
      expect(avatar.feedbackScore, 0);
      expect(avatar.vocab['start']!.isNotEmpty, true);
    });

    test('Training adds new phrases and saves them', () async {
      final avatar = await VocalAvatar.load();
      avatar.train('mid', 'Test phrase — keep running!');
      await avatar.save();

      final reloaded = await VocalAvatar.load();
      expect(reloaded.vocab['mid']!.contains('Test phrase — keep running!'), true);
    });

    test('Feedback updates score and persists', () async {
      final avatar = await VocalAvatar.load();
      final initialScore = avatar.feedbackScore;

      avatar.updateFeedback('positive');
      await avatar.save();

      final reloaded = await VocalAvatar.load();
      expect(reloaded.feedbackScore, initialScore + 1);
    });

    test('Phrase generation works with stages', () async {
      final avatar = await VocalAvatar.load();
      final phrase = avatar.choosePhrase('start');
      print('Start phrase: $phrase');
      expect(phrase.isNotEmpty, true);
    });
  });
}
