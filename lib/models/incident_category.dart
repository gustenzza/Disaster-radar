enum IncidentCategory {
  war,
  virus,
  assault,
  ufo,
  catastrophe,
  utility;

  String get displayName {
    switch (this) {
      case IncidentCategory.war:
        return 'War / Conflict';
      case IncidentCategory.virus:
        return 'Virus / Outbreak';
      case IncidentCategory.assault:
        return 'Physical Assault';
      case IncidentCategory.ufo:
        return 'UFO / Unexplained';
      case IncidentCategory.catastrophe:
        return 'Natural Catastrophe';
      case IncidentCategory.utility:
        return 'Public Utility Failure';
    }
  }

  String get emoji {
    switch (this) {
      case IncidentCategory.war:
        return '⚔️';
      case IncidentCategory.virus:
        return '🦠';
      case IncidentCategory.assault:
        return '🚨';
      case IncidentCategory.ufo:
        return '🛸';
      case IncidentCategory.catastrophe:
        return '🌋';
      case IncidentCategory.utility:
        return '⚡';
    }
  }
}
