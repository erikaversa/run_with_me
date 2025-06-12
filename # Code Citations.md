# Code Citations

## License: unknown
https://github.com/Alan-sa/news/blob/d0347780c1f64d8dc22b5a11b36061f1e17e0136/lib/assistant/services/chat_service.dart

```
;

  Future<String> getResponse(String prompt) async {
    final response = await http.post(
      Uri
```


## License: unknown
https://github.com/Alan-sa/news/blob/d0347780c1f64d8dc22b5a11b36061f1e17e0136/lib/assistant/services/chat_service.dart

```
;

  Future<String> getResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body
```

