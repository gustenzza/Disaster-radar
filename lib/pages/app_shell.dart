import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/services/incident_service.dart';
import 'package:disaster_radar/theme.dart';
import 'package:disaster_radar/widgets/app/map_view.dart';
import 'package:disaster_radar/widgets/app/shorts_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppView { map, shorts }

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppView _currentView = AppView.map;
  final _incidentService = IncidentService();
  List<Incident> _incidents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadIncidents();
  }

  Future<void> _loadIncidents() async {
    try {
      final incidents = await _incidentService.getAllIncidents();
      if (mounted) {
        setState(() {
          _incidents = incidents;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.darkSurface,
      body: Stack(
        children: [
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: DarkModeColors.darkPrimary,
              ),
            )
          else
            _currentView == AppView.map
              ? MapView(incidents: _incidents)
              : ShortsView(incidents: _incidents),
          SafeArea(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                children: [
                  _buildTopBar(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/app/report'),
        backgroundColor: DarkModeColors.darkTertiary,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_alert, color: Colors.black),
        label: Text(
          'Report',
          style: context.textStyles.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: DarkModeColors.darkSurfaceVariant.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: DarkModeColors.darkOutline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildViewButton(
            icon: Icons.map,
            label: 'Map',
            isSelected: _currentView == AppView.map,
            onTap: () => setState(() => _currentView = AppView.map),
          ),
          SizedBox(width: AppSpacing.xs),
          _buildViewButton(
            icon: Icons.video_library,
            label: 'Shorts',
            isSelected: _currentView == AppView.shorts,
            onTap: () => setState(() => _currentView = AppView.shorts),
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
            ? DarkModeColors.darkPrimary
            : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.black : DarkModeColors.darkOnSurfaceVariant,
            ),
            SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: context.textStyles.titleMedium?.copyWith(
                color: isSelected ? Colors.black : DarkModeColors.darkOnSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
