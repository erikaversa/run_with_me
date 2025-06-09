import 'package:flutter/material.dart';
import '../theme/app_text.dart';

/// Card compatta per una statistica (es: distanza, tempo, passo)
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(label, style: AppText.label),
            Text(
              value,
              style: AppText.value.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
