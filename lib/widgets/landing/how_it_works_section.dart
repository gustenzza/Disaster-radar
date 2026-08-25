import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          Text(
            'How It Works',
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
                    Expanded(child: _buildStep(
                      context,
                      Icons.camera_alt,
                      'Capture Evidence',
                      'Upload real photo and video evidence of incidents as they happen.',
                      DarkModeColors.darkSecondary,
                    )),
                    SizedBox(width: AppSpacing.xl),
                    Expanded(child: _buildStep(
                      context,
                      Icons.location_pin,
                      'Lock GPS Coordinates',
                      'Pinpoint exact location of incidents with precise GPS data.',
                      DarkModeColors.darkPrimary,
                    )),
                    SizedBox(width: AppSpacing.xl),
                    Expanded(child: _buildStep(
                      context,
                      Icons.public,
                      'Alert the Network',
                      'Broadcast real-time alerts to local users and emergency services.',
                      DarkModeColors.darkTertiary,
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildStep(
                      context,
                      Icons.camera_alt,
                      'Capture Evidence',
                      'Upload real photo and video evidence of incidents as they happen.',
                      DarkModeColors.darkSecondary,
                    ),
                    SizedBox(height: AppSpacing.xl),
                    _buildStep(
                      context,
                      Icons.location_pin,
                      'Lock GPS Coordinates',
                      'Pinpoint exact location of incidents with precise GPS data.',
                      DarkModeColors.darkPrimary,
                    ),
                    SizedBox(height: AppSpacing.xl),
                    _buildStep(
                      context,
                      Icons.public,
                      'Alert the Network',
                      'Broadcast real-time alerts to local users and emergency services.',
                      DarkModeColors.darkTertiary,
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

  Widget _buildStep(BuildContext context, IconData icon, String title, String description, Color color) {
    return Container(
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: AppSpacing.paddingLg,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: color),
          ),
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
