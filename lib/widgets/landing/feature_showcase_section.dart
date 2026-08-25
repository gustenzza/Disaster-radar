import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';

class FeatureShowcaseSection extends StatelessWidget {
  const FeatureShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          Text(
            'Features',
            style: context.textStyles.headlineLarge?.copyWith(
              color: DarkModeColors.darkOnSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildFeatureCard(
                      context,
                      Icons.map,
                      'Interactive Map',
                      'Real-time incident mapping with color-coded categories and location-based alerts.',
                    )),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(child: _buildFeatureCard(
                      context,
                      Icons.video_library,
                      'Shorts Feed',
                      'TikTok-style vertical video feed showcasing crowdsourced incident reports.',
                    )),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(child: _buildFeatureCard(
                      context,
                      Icons.category,
                      'Disaster Categories',
                      'War, Virus, Assault, UFO, Natural Catastrophe, and Utility Failure tracking.',
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildFeatureCard(
                      context,
                      Icons.map,
                      'Interactive Map',
                      'Real-time incident mapping with color-coded categories and location-based alerts.',
                    ),
                    SizedBox(height: AppSpacing.lg),
                    _buildFeatureCard(
                      context,
                      Icons.video_library,
                      'Shorts Feed',
                      'TikTok-style vertical video feed showcasing crowdsourced incident reports.',
                    ),
                    SizedBox(height: AppSpacing.lg),
                    _buildFeatureCard(
                      context,
                      Icons.category,
                      'Disaster Categories',
                      'War, Virus, Assault, UFO, Natural Catastrophe, and Utility Failure tracking.',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, String description) {
    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: DarkModeColors.darkPrimary),
          SizedBox(height: AppSpacing.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textStyles.titleLarge?.copyWith(
              color: DarkModeColors.darkOnSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            description,
            textAlign: TextAlign.center,
            style: context.textStyles.bodyMedium?.copyWith(
              color: DarkModeColors.darkOnSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
