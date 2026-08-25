import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurfaceVariant,
        border: Border(
          top: BorderSide(
            color: DarkModeColors.darkOutline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Disaster Radar',
            style: context.textStyles.titleLarge?.copyWith(
              color: DarkModeColors.darkPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            '© 2024 Disaster Radar. Crowdsourced Catastrophe Tracking.',
            textAlign: TextAlign.center,
            style: context.textStyles.bodySmall?.copyWith(
              color: DarkModeColors.darkOnSurfaceVariant,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => _showContactModal(context),
                child: Text(
                  'Contact',
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: DarkModeColors.darkSecondary,
                  ),
                ),
              ),
              Text(
                ' • ',
                style: context.textStyles.bodyMedium?.copyWith(
                  color: DarkModeColors.darkOnSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: DarkModeColors.darkSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: DarkModeColors.darkSurface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: context.textStyles.headlineSmall?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkOutline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkPrimary),
                ),
              ),
              style: TextStyle(color: DarkModeColors.darkOnSurface),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkOutline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkPrimary),
                ),
              ),
              style: TextStyle(color: DarkModeColors.darkOnSurface),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkOutline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: DarkModeColors.darkPrimary),
                ),
              ),
              style: TextStyle(color: DarkModeColors.darkOnSurface),
            ),
            SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DarkModeColors.darkPrimary,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: Text(
                  'Send Message',
                  style: context.textStyles.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
