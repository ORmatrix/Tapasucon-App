import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapViewPage extends StatelessWidget {
  final String title;
  final double latitude;
  final double longitude;

  const MapViewPage({
    super.key,
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  Future<void> _openGoogleMap(double lat, double lng) async {
    final Uri googleMapsAppUrl = Uri.parse("geo:$lat,$lng?q=$lat,$lng");
    final Uri googleMapsWebUrl =
    Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    try {
      if (await canLaunchUrl(googleMapsAppUrl)) {
        await launchUrl(googleMapsAppUrl,
            mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(googleMapsWebUrl)) {
        await launchUrl(googleMapsWebUrl,
            mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not open Google Maps.");
      }
    } catch (e) {
      debugPrint("Error opening Google Maps: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Open Maps as soon as page is loaded
    Future.delayed(Duration.zero, () {
      _openGoogleMap(latitude, longitude);
      Navigator.pop(context); // close after redirect
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
