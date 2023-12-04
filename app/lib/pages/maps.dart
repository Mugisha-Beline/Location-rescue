import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../datamanagers/database_manager.dart';

class MapPage extends StatefulWidget {
  final List<LocationItem> locationItems;

  const MapPage({Key? key, required this.locationItems}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Update with the default location
          zoom: 10.0, // Adjust the initial zoom level
        ),
        markers: _createMarkers(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the FeedbackPage
          Navigator.of(context).pushReplacementNamed('/feedback');
        },
        child: Icon(Icons.feedback),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Set<Marker> _createMarkers() {
    return widget.locationItems.map((item) {
      return Marker(
        markerId: MarkerId(item.name),
      
        infoWindow: InfoWindow(
          title: item.name,
          snippet: item.description,
        ),
      );
    }).toSet();
  }
}
