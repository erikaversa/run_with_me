import 'dart:convert';
import 'package:http/http.dart' as http;

class OllamaService {
  final String baseUrl;
  final String model;

  OllamaService({
    this.baseUrl = 'http://localhost:11434',
    this.model = 'farpluto/lite-mistral-v2',
  });

  Future<String> prompt(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'model': model, 'prompt': prompt}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? '';
    } else {
      throw Exception('Ollama error: ${response.body}');
    }
  }
}
