import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl * 3,
      ),
      child: Column(
        children: [
          Text(
            'DISASTER RADAR',
            style: context.textStyles.labelLarge?.copyWith(
              color: DarkModeColors.darkPrimary,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            'The Frontline,\nMapped by You.',
            textAlign: TextAlign.center,
            style: context.textStyles.displayMedium?.copyWith(
              color: DarkModeColors.darkOnSurface,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Real-time, crowdsourced visual tracking of catastrophes, hazards, and infrastructure failures. See what\'s happening. Report what you see.',
              textAlign: TextAlign.center,
              style: context.textStyles.titleLarge?.copyWith(
                color: DarkModeColors.darkOnSurfaceVariant,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
          ElevatedButton(
            onPressed: () => context.go('/app'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DarkModeColors.darkPrimary,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.lg,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.radar, color: Colors.black),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'Launch Tracker',
                  style: context.textStyles.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
