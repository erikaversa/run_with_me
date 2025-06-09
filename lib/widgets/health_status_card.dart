import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../utils/health_utils.dart';

/// Card compatta che mostra battito cardiaco, VO₂ effort e colore zona
class HealthStatusCard extends StatelessWidget {
  final int heartRate;
  final int vo2Effort; // in percentuale (%)

  const HealthStatusCard({
    super.key,
    required this.heartRate,
    required this.vo2Effort,
  });

  @override
  Widget build(BuildContext context) {
    final zoneColor = getZoneColor(heartRate, vo2Effort);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: zoneColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(label: '❤️ BPM', value: '$heartRate'),
          _StatColumn(label: 'VO₂ %', value: '$vo2Effort%'),
          Icon(
            Icons.circle,
            color: zoneColor,
            size: 18,
            semanticLabel: 'Stato zona',
          ),
        ],
      ),
    );
  }
}

/// Widget interno per rappresentare ogni metrica
class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: AppText.label),
        const SizedBox(height: 4),
        Text(value, style: AppText.value.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
