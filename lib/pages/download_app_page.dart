import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:disaster_radar/theme.dart';

class DownloadAppPage extends StatelessWidget {
  const DownloadAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.darkSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DarkModeColors.darkOnSurface),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: 80,
                color: DarkModeColors.darkPrimary,
              ),
              SizedBox(height: AppSpacing.lg),
              Text(
                'Get the Mobile App',
                style: context.textStyles.headlineMedium?.copyWith(
                  color: DarkModeColors.darkOnSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                'The Disaster Radar tracker is only available on mobile devices to ensure accurate GPS location and real-time reporting capabilities.',
                style: context.textStyles.bodyLarge?.copyWith(
                  color: DarkModeColors.darkOnSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.xxl),
              _buildStoreButton(
                context,
                icon: Icons.shop,
                title: 'Get it on',
                store: 'Google Play',
                onTap: () {
                  // In a real app, use url_launcher to open the store link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Redirecting to Google Play Store...')),
                  );
                },
              ),
              SizedBox(height: AppSpacing.md),
              _buildStoreButton(
                context,
                icon: Icons.apple,
                title: 'Download on the',
                store: 'App Store',
                onTap: () {
                  // In a real app, use url_launcher to open the store link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Redirecting to App Store...')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String store,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: DarkModeColors.darkOutline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyles.labelSmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  store,
                  style: context.textStyles.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
