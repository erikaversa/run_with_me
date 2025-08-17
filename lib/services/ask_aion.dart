import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:run_with_me_voice/avatar_voice.dart';

Future<void> askAionAndSpeak(String question, TtsAvatarVoice avatar) async {
  var response = await http.post(
    Uri.parse(
        "http://localhost:11434"), // Replace with your server IP if needed
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"prompt": question}),
  );

  String answer;
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    answer = data['response'] ?? "No response.";
  } else {
    answer = "Oops, something went wrong!";
  }
  await avatar.speak(answer);
}
