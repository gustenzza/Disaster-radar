import 'package:disaster_radar/pages/app_shell.dart';
import 'package:disaster_radar/pages/landing_page.dart';
import 'package:disaster_radar/pages/report_incident_page.dart';
import 'package:disaster_radar/pages/download_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: kIsWeb ? AppRoutes.home : AppRoutes.app,
    redirect: (context, state) {
      if (kIsWeb) {
        if (state.uri.path.startsWith(AppRoutes.app)) {
          return AppRoutes.download;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const LandingPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.app,
        name: 'app',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const AppShell(),
        ),
      ),
      GoRoute(
        path: AppRoutes.report,
        name: 'report',
        pageBuilder: (context, state) => MaterialPage(
          child: const ReportIncidentPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.download,
        name: 'download',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const DownloadAppPage(),
        ),
      ),
    ],
  );
}

class AppRoutes {
  static const String home = '/';
  static const String app = '/app';
  static const String report = '/app/report';
  static const String download = '/download';
}
