import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/models/incident_category.dart';
import 'package:disaster_radar/theme.dart';
import 'package:flutter/material.dart';

class ShortsView extends StatelessWidget {
  final List<Incident> incidents;

  const ShortsView({super.key, required this.incidents});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: incidents.length,
      itemBuilder: (context, index) => _buildShortCard(context, incidents[index]),
    );
  }

  Widget _buildShortCard(BuildContext context, Incident incident) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (incident.mediaUrl != null)
          Image.asset(
            incident.mediaUrl!,
            fit: BoxFit.cover,
          )
        else
          Container(color: DarkModeColors.darkSurfaceVariant),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                _buildCategoryBadge(incident),
                SizedBox(height: AppSpacing.md),
                Text(
                  incident.title,
                  style: context.textStyles.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(Icons.location_pin, size: 16, color: Colors.white.withValues(alpha: 0.8)),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        incident.locationName,
                        style: context.textStyles.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      ' • ${_getTimeAgo(incident.createdAt)}',
                      style: context.textStyles.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  incident.description,
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    _buildActionButton(
                      Icons.verified,
                      '${incident.verifyCount}',
                      DarkModeColors.darkPrimary,
                    ),
                    SizedBox(width: AppSpacing.md),
                    _buildActionButton(
                      Icons.share,
                      'Share',
                      DarkModeColors.darkSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(Incident incident) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _getCategoryColor(incident).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            incident.category.emoji,
            style: const TextStyle(fontSize: 14),
          ),
          SizedBox(width: AppSpacing.sm),
          Text(
            incident.category.displayName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(Incident incident) {
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

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
