import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'stat_card.dart';
import 'health_status_card.dart';

class RunDashboard extends StatelessWidget {
  const RunDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 📊 Statistiche principali
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            StatCard(label: 'Distanza', value: '5.3 km', emoji: '📏'),
            StatCard(label: 'Tempo', value: '32:20', emoji: '⏱️'),
            StatCard(label: 'Passo', value: '6:05 /km', emoji: '👟'),
          ],
        ),
        SizedBox(height: 20),
        // ❤️‍🔥 Stato Salute (card compatta)
        HealthStatusCard(heartRate: 145, vo2Effort: 82),
        SizedBox(height: 30),
        // 🎮 Pulsanti azione
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            ActionButton(label: 'Start', emoji: '🏁', onPressed: () {}),
            ActionButton(label: 'Pausa', emoji: '⏸️', onPressed: () {}),
            ActionButton(label: 'Stop', emoji: '🟥', onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final String emoji;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.emoji,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 2,
        textStyle: AppText.value.copyWith(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
