import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../utils/health_utils.dart';

class HealthStatusCard extends StatelessWidget {
  final int heartRate;
  final int age;
  final String gender;

  const HealthStatusCard({
    super.key,
    required this.heartRate,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final maxHR = getMaxHeartRate(age, gender);
    final voc = getVocPercentage(heartRate, maxHR);
    final inZone = isInTargetZone(heartRate, maxHR);
    final emoji = inZone ? '💚🫀' : '💔🫀';
    final color = inZone ? AppColors.green : AppColors.red;

    return Card(
      color: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                emoji,
                key: ValueKey(emoji),
                style: const TextStyle(fontSize: 48),
              ),
            ),
            const SizedBox(height: 12),
            Text('Health Monitor', style: AppText.heading),
            const SizedBox(height: 16),
            _infoRow('❤️ Heart Rate', '$heartRate bpm'),
            _infoRow('🫁 VO₂ Effort', '${voc.toStringAsFixed(1)}%'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                inZone ? 'In Zone' : 'Out of Zone',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppText.label),
          Text(value, style: AppText.value),
        ],
      ),
    );
  }
}
