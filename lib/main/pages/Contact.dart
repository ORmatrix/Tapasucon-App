import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

  final Map<String, dynamic> contactInfo = {
    'name': 'Aarupadai Veedu Medical College',
    'image': 'https://ormatrix.in/tapasucon2025/Admin/workshop/avmc.webp',
    'latitude': 11.83142129554976,
    'longitude': 79.78333019879949,
    'contacts': [
      '+91 7788997758',
      '+91 9566066780',
      '+91 7200447130',
    ],
  };

  /// Generate a Google Maps link
  String _mapsUrl(double lat, double lng) {
    return "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  }

  /// Open Google Maps (App → fallback browser)
  Future<void> _openMap(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  /// Make a phone call
  Future<void> _callNumber(String number) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);
    if (!await launchUrl(callUri)) {
      throw "Could not call $number";
    }
  }

  @override
  Widget build(BuildContext context) {
    final String mapUrl =
    _mapsUrl(contactInfo['latitude'], contactInfo['longitude']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us", style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFE3F2FD)],
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image with fullscreen preview
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullScreenImage(
                        tag: contactInfo['name'],
                        imageUrl: contactInfo['image'],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: contactInfo['name'],
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      contactInfo['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Details
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      contactInfo['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Open Maps Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text("Open in Maps",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () => _openMap(mapUrl),
                    ),
                    const SizedBox(height: 20),

                    // Contact Numbers
                    const Text(
                      "Contact:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: (contactInfo['contacts'] as List<String>)
                          .map((number) => Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 4),
                        child: InkWell(
                          onTap: () => _callNumber(number),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.phone,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  number,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
