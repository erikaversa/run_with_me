import 'package:flutter_test/flutter_test.dart';
import 'package:run_with_me_voice/services/ollama_service.dart';

void main() {
  test('OllamaService returns a response from farpluto/lite-mistral-v2',
      () async {
    // Replace 'server-ip' with your actual server IP address
    final ollama = OllamaService(baseUrl: 'http://server-ip:11434');
    final response = await ollama.prompt('Say hello in a friendly way');
    print('Ollama response: $response');
    expect(response.isNotEmpty, true);
  });
}
