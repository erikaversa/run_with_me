import 'dart:convert';
import 'package:http/http.dart' as http;

/// Servizio che comunica con Ollama localmente
class LLMService {
  final String apiUrl = 'http://localhost:11434/api/generate';

  Future<String> askAI(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "model": "llama3", // Cambia con il nome del modello caricato in Ollama
        "prompt": prompt,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['response'] ?? 'Risposta vuota';
    } else {
      throw Exception('Errore chiamata LLM: {response.statusCode}');
    }
  }
}
