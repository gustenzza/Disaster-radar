import 'dart:convert';
import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/models/incident_category.dart';
import 'package:disaster_radar/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class IncidentService {
  static const String _storageKey = 'incidents';
  static const _uuid = Uuid();

  Future<List<Incident>> getAllIncidents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString(_storageKey);
      
      if (data == null || data.isEmpty) {
        final sampleData = _getSampleIncidents();
        await _saveIncidents(sampleData);
        return sampleData;
      }

      final List<dynamic> jsonList = json.decode(data);
      final incidents = jsonList.map((json) {
        try {
          return Incident.fromJson(json as Map<String, dynamic>);
        } catch (e) {
          debugPrint('Failed to parse incident: $e');
          return null;
        }
      }).whereType<Incident>().toList();

      if (incidents.isEmpty) {
        final sampleData = _getSampleIncidents();
        await _saveIncidents(sampleData);
        return sampleData;
      }

      return incidents;
    } catch (e) {
      debugPrint('Failed to load incidents: $e');
      final sampleData = _getSampleIncidents();
      await _saveIncidents(sampleData);
      return sampleData;
    }
  }

  Future<void> addIncident(Incident incident) async {
    final incidents = await getAllIncidents();
    incidents.insert(0, incident);
    await _saveIncidents(incidents);
  }

  Future<void> updateIncident(Incident incident) async {
    final incidents = await getAllIncidents();
    final index = incidents.indexWhere((i) => i.id == incident.id);
    if (index != -1) {
      incidents[index] = incident;
      await _saveIncidents(incidents);
    }
  }

  Future<void> deleteIncident(String id) async {
    final incidents = await getAllIncidents();
    incidents.removeWhere((i) => i.id == id);
    await _saveIncidents(incidents);
  }

  Future<void> _saveIncidents(List<Incident> incidents) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = incidents.map((i) => i.toJson()).toList();
      await prefs.setString(_storageKey, json.encode(jsonList));
    } catch (e) {
      debugPrint('Failed to save incidents: $e');
    }
  }

  List<Incident> _getSampleIncidents() {
    final now = DateTime.now();
    final sampleUser1 = User(
      id: _uuid.v4(),
      name: 'Sarah Chen',
      email: 'sarah.chen@example.com',
      createdAt: now.subtract(const Duration(days: 30)),
      updatedAt: now.subtract(const Duration(days: 30)),
    );
    
    final sampleUser2 = User(
      id: _uuid.v4(),
      name: 'Marcus Johnson',
      email: 'marcus.j@example.com',
      createdAt: now.subtract(const Duration(days: 25)),
      updatedAt: now.subtract(const Duration(days: 25)),
    );

    final sampleUser3 = User(
      id: _uuid.v4(),
      name: 'Elena Rodriguez',
      email: 'elena.r@example.com',
      createdAt: now.subtract(const Duration(days: 20)),
      updatedAt: now.subtract(const Duration(days: 20)),
    );

    return [
      Incident(
        id: _uuid.v4(),
        title: 'Major Wildfire Spreading Fast',
        description: 'Large wildfire consuming forest area, multiple homes threatened. Fire crews on scene.',
        category: IncidentCategory.catastrophe,
        latitude: 34.0522,
        longitude: -118.2437,
        locationName: 'Los Angeles, CA',
        mediaUrl: 'assets/images/Wildfire_Disaster_null_1784717475778.jpg',
        reporter: sampleUser1,
        verifyCount: 247,
        createdAt: now.subtract(const Duration(minutes: 15)),
        updatedAt: now.subtract(const Duration(minutes: 15)),
      ),
      Incident(
        id: _uuid.v4(),
        title: 'Building Collapse After Earthquake',
        description: '6.2 magnitude earthquake causes several buildings to collapse. Search and rescue operations ongoing.',
        category: IncidentCategory.catastrophe,
        latitude: 37.7749,
        longitude: -122.4194,
        locationName: 'San Francisco, CA',
        mediaUrl: 'assets/images/Earthquake_Destruction_null_1784717476437.jpg',
        reporter: sampleUser2,
        verifyCount: 523,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      Incident(
        id: _uuid.v4(),
        title: 'Tsunami Warning Issued',
        description: 'Coastal areas evacuated following underwater earthquake. Wave expected in 30 minutes.',
        category: IncidentCategory.catastrophe,
        latitude: 21.3099,
        longitude: -157.8581,
        locationName: 'Honolulu, HI',
        mediaUrl: 'assets/images/Tsunami_Wave_null_1784717477388.jpg',
        reporter: sampleUser3,
        verifyCount: 892,
        createdAt: now.subtract(const Duration(minutes: 45)),
        updatedAt: now.subtract(const Duration(minutes: 45)),
      ),
      Incident(
        id: _uuid.v4(),
        title: 'Armed Conflict Near Border',
        description: 'Reports of gunfire and explosions near the border checkpoint. Civilians advised to shelter in place.',
        category: IncidentCategory.war,
        latitude: 32.5149,
        longitude: -117.0382,
        locationName: 'Tijuana Border',
        mediaUrl: 'assets/images/Military_Conflict_null_1784717478041.jpg',
        reporter: sampleUser1,
        verifyCount: 156,
        createdAt: now.subtract(const Duration(hours: 1)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      Incident(
        id: _uuid.v4(),
        title: 'Outbreak Confirmed at Hospital',
        description: 'Multiple cases of infectious disease confirmed. Hospital under quarantine, contact tracing initiated.',
        category: IncidentCategory.virus,
        latitude: 40.7128,
        longitude: -74.0060,
        locationName: 'New York, NY',
        mediaUrl: 'assets/images/Medical_Outbreak_null_1784717478945.jpg',
        reporter: sampleUser2,
        verifyCount: 634,
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
      Incident(
        id: _uuid.v4(),
        title: 'Power Grid Failure',
        description: 'Major power outage affecting entire downtown area. Estimated 50,000 homes without electricity.',
        category: IncidentCategory.utility,
        latitude: 41.8781,
        longitude: -87.6298,
        locationName: 'Chicago, IL',
        mediaUrl: 'assets/images/Infrastructure_Failure_null_1784717479915.jpg',
        reporter: sampleUser3,
        verifyCount: 412,
        createdAt: now.subtract(const Duration(minutes: 30)),
        updatedAt: now.subtract(const Duration(minutes: 30)),
      ),
    ];
  }
}
