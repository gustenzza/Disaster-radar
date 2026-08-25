import 'package:disaster_radar/models/incident.dart';
import 'package:disaster_radar/theme.dart';
import 'package:disaster_radar/widgets/app/incident_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final List<Incident> incidents;

  const MapView({super.key, required this.incidents});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  @override
  void didUpdateWidget(MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.incidents != oldWidget.incidents) {
      _createMarkers();
    }
  }

  void _createMarkers() {
    _markers = widget.incidents.map((incident) {
      return Marker(
        markerId: MarkerId(incident.id),
        position: LatLng(incident.latitude, incident.longitude),
        onTap: () => _showIncidentSheet(incident),
        icon: BitmapDescriptor.defaultMarkerWithHue(_getMarkerHue(incident)),
      );
    }).toSet();
    setState(() {});
  }

  double _getMarkerHue(Incident incident) {
    switch (incident.category.name) {
      case 'war':
        return BitmapDescriptor.hueRed;
      case 'virus':
        return BitmapDescriptor.hueViolet;
      case 'assault':
        return BitmapDescriptor.hueOrange;
      case 'ufo':
        return BitmapDescriptor.hueCyan;
      case 'catastrophe':
        return BitmapDescriptor.hueYellow;
      case 'utility':
        return BitmapDescriptor.hueGreen;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  void _showIncidentSheet(Incident incident) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => IncidentBottomSheet(incident: incident),
    );
  }

  @override
  Widget build(BuildContext context) {
    final centerLat = widget.incidents.isNotEmpty
      ? widget.incidents.map((i) => i.latitude).reduce((a, b) => a + b) / widget.incidents.length
      : 37.7749;
    final centerLng = widget.incidents.isNotEmpty
      ? widget.incidents.map((i) => i.longitude).reduce((a, b) => a + b) / widget.incidents.length
      : -122.4194;

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(centerLat, centerLng),
        zoom: 5,
      ),
      markers: _markers,
      onMapCreated: (controller) => _mapController = controller,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      style: _darkMapStyle,
    );
  }

  static const String _darkMapStyle = '''[
    {
      "elementType": "geometry",
      "stylers": [{"color": "#212121"}]
    },
    {
      "elementType": "labels.icon",
      "stylers": [{"visibility": "off"}]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [{"color": "#212121"}]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#757575"}]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [{"color": "#181818"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [{"color": "#2c2c2c"}]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [{"color": "#8a8a8a"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#000000"}]
    }
  ]''';
}
