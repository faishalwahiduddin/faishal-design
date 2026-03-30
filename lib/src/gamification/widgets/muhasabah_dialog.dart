import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_typography.dart';
import '../../providers/shared_preferences_provider.dart';

/// Constants for Muhasabah Dialog quotes.
const _muhasabahQuotes = [
  {
    'arabic': 'وَمَن يَتَوَكَّلْ عَلَى ٱللَّهِ فَهُوَ حَسْبُهُۥٓ',
    'translation': 'Dan barangsiapa yang bertawakkal kepada Allah niscaya Allah akan mencukupkan (keperluan)nya.',
    'reference': 'QS. At-Talaq: 3',
  },
  {
    'arabic': 'لَا تَقْنَطُوا۟ مِن رَّحْمَةِ ٱللَّهِ',
    'translation': 'Janganlah kamu berputus asa dari rahmat Allah.',
    'reference': 'QS. Az-Zumar: 53',
  },
  {
    'arabic': 'لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
    'translation': 'Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya.',
    'reference': 'QS. Al-Baqarah: 286',
  },
  {
    'arabic': 'أَحَبُّ الْأَعْمَالِ إِلَى اللَّهِ تَعَالَى أَدْوَمُهَا وَإِنْ قَلَّ',
    'translation': 'Amalan yang paling dicintai oleh Allah Ta\'ala adalah amalan yang kontinu walaupun itu sedikit.',
    'reference': 'HR. Bukhari & Muslim',
  },
  {
    'arabic': 'مَنْ نَامَ عَنْ حِزْبِهِ، أَوْ عَنْ شَيْءٍ مِنْهُ، فَقَرَأَهُ فِيمَا بَيْنَ صَلَاةِ الْفَجْرِ، وَصَلَاةِ الظُّهْرِ، كُتِبَ لَهُ كَأَنَّمَا قَرَأَهُ مِنَ اللَّيْلِ',
    'translation': 'Barangsiapa tertidur dari hizibnya (wirid malamnya) atau sebagian darinya, lalu ia membacanya antara shalat fajar dan shalat zhuhur, maka dicatat baginya seolah-olah ia telah membacanya di waktu malam.',
    'reference': 'HR. Muslim',
  },
];

/// Keys for SharedPreferences.
const _lastShownDateKey = 'muhasabah_last_shown_date';

/// A gentle, dismissible bottom sheet dialog shown when a streak breaks.
class MuhasabahDialog extends ConsumerWidget {
  /// Creates a MuhasabahDialog.
  const MuhasabahDialog({
    super.key,
    required this.brokenStreakDays,
    this.onResume,
  });

  /// The number of streak days that were lost.
  final int brokenStreakDays;

  /// Callback when the user taps "Kembali berdzikir".
  final VoidCallback? onResume;

  /// Shows the MuhasabahDialog as a bottom sheet if it hasn't been shown today.
  static Future<void> showIfNeeded(
    BuildContext context,
    WidgetRef ref, {
    required int brokenStreakDays,
    VoidCallback? onResume,
  }) async {
    // Check if broken streak is significant (e.g., 3+ days as per requirement)
    if (brokenStreakDays < 3) return;

    final prefs = ref.read(sharedPreferencesProvider);
    final today = DateTime.now().toIso8601String().split('T').first;
    final lastShownDate = prefs.getString(_lastShownDateKey);

    // Never shown more than once per day
    if (lastShownDate == today) return;

    // Save shown date BEFORE showing the dialog so it doesn't wait for dialog dismiss
    await prefs.setString(_lastShownDateKey, today);

    // Show dialog
    if (context.mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MuhasabahDialog(
          brokenStreakDays: brokenStreakDays,
          onResume: onResume,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // Select a random quote
    final random = Random();
    final quote = _muhasabahQuotes[random.nextInt(_muhasabahQuotes.length)];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle for drag down
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              // Header Image/Icon
              Icon(
                Icons.healing,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 16),
              
              // Title
              Text(
                'Jangan Menyerah',
                textAlign: TextAlign.center,
                style: AppTypography.headlineMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              
              // Subtitle
              Text(
                'Streak $brokenStreakDays hari Anda terhenti, namun rahmat Allah tak pernah putus.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 32),
              
              // Quote Box
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      quote['arabic']!,
                      textAlign: TextAlign.center,
                      style: AppTypography.arabicMedium.copyWith(
                        color: theme.colorScheme.primary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${quote['translation']}',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      quote['reference']!,
                      textAlign: TextAlign.center,
                      style: AppTypography.labelLarge.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // CTA Button
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onResume?.call();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Kembali Berdzikir',
                  style: AppTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Dismiss Button
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                child: Text(
                  'Mungkin Nanti',
                  style: AppTypography.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
