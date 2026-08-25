import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/models/incident_category.dart';
import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';

class IncidentBottomSheet extends StatelessWidget {
  final Incident incident;

  const IncidentBottomSheet({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (incident.mediaUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
              child: Image.asset(
                incident.mediaUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: AppSpacing.paddingLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor().withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(incident.category.emoji),
                          SizedBox(width: AppSpacing.sm),
                          Text(
                            incident.category.displayName,
                            style: context.textStyles.labelMedium?.copyWith(
                              color: _getCategoryColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  incident.title,
                  style: context.textStyles.titleLarge?.copyWith(
                    color: DarkModeColors.darkOnSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(Icons.location_pin, size: 16, color: DarkModeColors.darkSecondary),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        incident.locationName,
                        style: context.textStyles.bodyMedium?.copyWith(
                          color: DarkModeColors.darkOnSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      '${_calculateDistance(incident)} km away',
                      style: context.textStyles.bodySmall?.copyWith(
                        color: DarkModeColors.darkOnSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  incident.description,
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: DarkModeColors.darkOnSurface,
                    height: 1.5,
                  ),
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
                      'Watch Short',
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
        ],
      ),
    );
  }

  Color _getCategoryColor() {
    switch (incident.category) {
      case IncidentCategory.war:
        return CategoryColors.war;
      case IncidentCategory.virus:
        return CategoryColors.virus;
      case IncidentCategory.assault:
        return CategoryColors.assault;
      case IncidentCategory.ufo:
        return CategoryColors.ufo;
      case IncidentCategory.catastrophe:
        return CategoryColors.catastrophe;
      case IncidentCategory.utility:
        return CategoryColors.utility;
    }
  }

  String _calculateDistance(Incident incident) {
    return (incident.verifyCount % 50 / 10).toStringAsFixed(1);
  }
}
