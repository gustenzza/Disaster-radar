import 'package:disaster_radar/theme.dart';
import 'package:disaster_radar/widgets/landing/hero_section.dart';
import 'package:disaster_radar/widgets/landing/how_it_works_section.dart';
import 'package:disaster_radar/widgets/landing/feature_showcase_section.dart';
import 'package:disaster_radar/widgets/landing/landing_footer.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.darkSurface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            SizedBox(height: AppSpacing.xxl * 2),
            const HowItWorksSection(),
            SizedBox(height: AppSpacing.xxl * 2),
            const FeatureShowcaseSection(),
            SizedBox(height: AppSpacing.xxl * 2),
            const LandingFooter(),
          ],
        ),
      ),
    );
  }
}
