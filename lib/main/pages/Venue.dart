import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VenuePage extends StatelessWidget {
  VenuePage({super.key});

  final List<Map<String, dynamic>> venues = [
    {
      'name': 'Aarupadai Veedu Medical College',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/avmc.webp',
      'latitude': 11.83142129554976,
      'longitude': 79.78333019879949,
    },
    {
      'name': 'Nilan Zingle Resort, Pondicherry',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/nilan_grand.jpg',
      'latitude': 11.873575610775351,
      'longitude': 79.77122793195232,
    },
    {
      'name': 'Sunway Manor',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/sunway.jpg',
      'latitude': 11.913110,
      'longitude': 79.812183,
    },
    {
      'name': 'Accord Pondicherry',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/accord.jpg',
      'latitude': 11.939918,
      'longitude': 79.808313,
    },
    {
      'name': 'RKN Residency',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/rkn.jpg',
      'latitude': 11.933458,
      'longitude': 79.834534,
    },
    {
      'name': 'Le Pondy Resort',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/lepondy.jpg',
      'latitude': 11.880353,
      'longitude': 79.827249,
    },
    {
      'name': 'The Shore',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/shore.jpg',
      'latitude': 11.929983,
      'longitude': 79.838616,
    },
    {
      'name': 'Lagoon Sarovar Premiere',
      'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/lagoon.jpg',
      'latitude': 11.898421,
      'longitude': 79.832055,
    },
  ];

  /// Generate a Google Maps link
  String _mapsUrl(double lat, double lng) {
    return "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  }

  /// Open Google Maps (app → fallback browser)
  Future<void> _openMap(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venue", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0072FF), Color(0xFF00C853)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          final String mapUrl =
          _mapsUrl(venue['latitude'], venue['longitude']);

          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFE8F5E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Image with fullscreen preview
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImage(
                          tag: venue['name'],
                          imageUrl: venue['image'],
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: venue['name'],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        venue['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Venue details
                // Venue details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venue['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Open in Maps Button (aligned left)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          icon: const Icon(Icons.location_on, color: Colors.white),
                          label: const Text(
                            "Open in Maps",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => _openMap(mapUrl),
                        ),
                      ),
                    ],
                  ),
                ),




              ],
            ),
          );
        },
      ),
    );
  }
}

/// Full screen image viewer
class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({
    super.key,
    required this.imageUrl,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
