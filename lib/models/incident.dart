import 'package:disaster_radar/models/incident_category.dart';
import 'package:disaster_radar/models/user.dart';

class Incident {
  final String id;
  final String title;
  final String description;
  final IncidentCategory category;
  final double latitude;
  final double longitude;
  final String locationName;
  final String? mediaUrl;
  final bool isVideo;
  final User reporter;
  final int verifyCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    this.mediaUrl,
    this.isVideo = false,
    required this.reporter,
    this.verifyCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category.name,
    'latitude': latitude,
    'longitude': longitude,
    'locationName': locationName,
    'mediaUrl': mediaUrl,
    'isVideo': isVideo,
    'reporter': reporter.toJson(),
    'verifyCount': verifyCount,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: IncidentCategory.values.firstWhere(
      (e) => e.name == json['category'],
    ),
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    locationName: json['locationName'] as String,
    mediaUrl: json['mediaUrl'] as String?,
    isVideo: json['isVideo'] as bool? ?? false,
    reporter: User.fromJson(json['reporter'] as Map<String, dynamic>),
    verifyCount: json['verifyCount'] as int? ?? 0,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Incident copyWith({
    String? id,
    String? title,
    String? description,
    IncidentCategory? category,
    double? latitude,
    double? longitude,
    String? locationName,
    String? mediaUrl,
    bool? isVideo,
    User? reporter,
    int? verifyCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Incident(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    locationName: locationName ?? this.locationName,
    mediaUrl: mediaUrl ?? this.mediaUrl,
    isVideo: isVideo ?? this.isVideo,
    reporter: reporter ?? this.reporter,
    verifyCount: verifyCount ?? this.verifyCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
