import 'package:flutter/material.dart';

class ScientificSchedulePage extends StatelessWidget {
  const ScientificSchedulePage({super.key});

  // Each day with its schedule image URLs (A4 size from server)
  final Map<String, List<String?>> schedules = const {
    "Day 1: 19 Sept 2025": [
      "https://ormatrix.in/tapasucon2025/Admin/workshop/preworkshop.jpg",
    ],
    "Day 2: 20 Sept 2025": [
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0001.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0002.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0003.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0004.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0005.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0006.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0007.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0008.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0009.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0010.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0011.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0012.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0013.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0014.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0015.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0016.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0017.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0018.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_1_2_page-0019.jpg",
    ],
    "Day 3: 21 Sept 2025": [
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0001.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0002.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0003.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0004.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0005.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0006.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0007.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0008.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0009.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0010.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0011.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0012.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0013.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0014.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0015.jpg",
      "https://ormatrix.in/tapasucon2025/Admin/workshop/Scientific%20Programme_Day_3_page-0016.jpg",



    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Scientific Schedule", style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: schedules.keys.map((day) {
          final images = schedules[day] ?? [];
          final hasImage = images.any((img) => img != null);

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: hasImage ? Colors.green : Colors.red,
                child: Icon(
                  hasImage ? Icons.event_available : Icons.event_busy,
                  color: Colors.white,
                ),
              ),
              title: Text(
                day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DaySchedulePage(
                      title: day,
                      images: images.whereType<String>().toList(),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Page for viewing images of a specific day
class DaySchedulePage extends StatelessWidget {
  final String title;
  final List<String> images;

  const DaySchedulePage({super.key, required this.title, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
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
      body: images.isEmpty
          ? const Center(
        child: Text(
          "📄 Schedule Not Available",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      )
          : ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImage(
                    tag: "$title-$index",
                    imageUrl: image,
                  ),
                ),
              );
            },
            child: Hero(
              tag: "$title-$index",
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 250,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text("⚠️ Failed to load image"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Full screen zoomable image viewer (for A4 schedules)
class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({super.key, required this.imageUrl, required this.tag});

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
              panEnabled: true,
              minScale: 0.8,
              maxScale: 4,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
