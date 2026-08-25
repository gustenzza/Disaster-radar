import 'dart:io';
import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/models/incident_category.dart';
import 'package:disaster_radar/models/user.dart';
import 'package:disaster_radar/services/incident_service.dart';
import 'package:disaster_radar/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _incidentService = IncidentService();
  final _uuid = const Uuid();
  
  IncidentCategory? _selectedCategory;
  XFile? _selectedImage;
  bool _isSubmitting = false;
  bool _isFetchingLocation = false;
  
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocation() async {
    setState(() => _isFetchingLocation = true);
    
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      } 

      Position position = await Geolocator.getCurrentPosition();
      
      if (mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _locationController.text = 'Lat: ${_latitude?.toStringAsFixed(4)}, Lng: ${_longitude?.toStringAsFixed(4)}';
          _isFetchingLocation = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
      if (mounted) {
        setState(() {
          _isFetchingLocation = false;
          _locationController.text = 'Location unavailable';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: DarkModeColors.darkError,
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _submitReport() async {
    if (_selectedCategory == null ||
        _titleController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all required fields'),
          backgroundColor: DarkModeColors.darkError,
        ),
      );
      return;
    }

    if (_latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Location is required to report an incident.'),
          backgroundColor: DarkModeColors.darkError,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final now = DateTime.now();
      final mockUser = User(
        id: _uuid.v4(),
        name: 'Current User',
        email: 'user@example.com',
        createdAt: now,
        updatedAt: now,
      );

      final incident = Incident(
        id: _uuid.v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory!,
        latitude: _latitude!,
        longitude: _longitude!,
        locationName: _locationController.text,
        reporter: mockUser,
        verifyCount: 0,
        createdAt: now,
        updatedAt: now,
      );

      await _incidentService.addIncident(incident);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Incident reported successfully'),
            backgroundColor: CategoryColors.utility,
          ),
        );
        context.pop();
      }
    } catch (e) {
      debugPrint('Error submitting report: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to submit report'),
            backgroundColor: DarkModeColors.darkError,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkModeColors.darkSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Report Incident',
          style: context.textStyles.titleLarge?.copyWith(
            color: DarkModeColors.darkOnSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: context.textStyles.titleMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: IncidentCategory.values.map((category) {
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                        ? _getCategoryColor(category).withValues(alpha: 0.2)
                        : DarkModeColors.darkSurfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border: Border.all(
                        color: isSelected
                          ? _getCategoryColor(category)
                          : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(category.emoji),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          category.displayName,
                          style: context.textStyles.labelMedium?.copyWith(
                            color: isSelected
                              ? _getCategoryColor(category)
                              : DarkModeColors.darkOnSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Media',
              style: context.textStyles.titleMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: DarkModeColors.darkSurfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: DarkModeColors.darkOutline,
                    width: 2,
                  ),
                ),
                child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: kIsWeb
                        ? Image.network(_selectedImage!.path, fit: BoxFit.cover)
                        : Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 48,
                          color: DarkModeColors.darkOnSurfaceVariant,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'Add Photo or Video',
                          style: context.textStyles.bodyMedium?.copyWith(
                            color: DarkModeColors.darkOnSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Title',
              style: context.textStyles.titleMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              controller: _titleController,
              style: TextStyle(color: DarkModeColors.darkOnSurface),
              decoration: InputDecoration(
                hintText: 'Brief description of the incident',
                hintStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                filled: true,
                fillColor: DarkModeColors.darkSurfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Description',
              style: context.textStyles.titleMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: TextStyle(color: DarkModeColors.darkOnSurface),
              decoration: InputDecoration(
                hintText: 'Provide more details about what happened',
                hintStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                filled: true,
                fillColor: DarkModeColors.darkSurfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              'Location',
              style: context.textStyles.titleMedium?.copyWith(
                color: DarkModeColors.darkOnSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              controller: _locationController,
              readOnly: true,
              style: TextStyle(color: DarkModeColors.darkOnSurface),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_pin, color: DarkModeColors.darkSecondary),
                suffixIcon: _isFetchingLocation 
                    ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(12),
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.my_location),
                        color: DarkModeColors.darkSecondary,
                        onPressed: _fetchLocation,
                      ),
                hintText: 'Fetching location...',
                hintStyle: TextStyle(color: DarkModeColors.darkOnSurfaceVariant),
                filled: true,
                fillColor: DarkModeColors.darkSurfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: DarkModeColors.darkPrimary,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : Text(
                      'Submit Report',
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

  Color _getCategoryColor(IncidentCategory category) {
    switch (category) {
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
}
