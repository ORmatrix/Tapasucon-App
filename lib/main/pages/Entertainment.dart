import 'package:flutter/material.dart';

// Workshop model
class Entertainment {
  final String id;
  final String title;
  final String imageUrl;

  Entertainment({required this.id, required this.title, required this.imageUrl});
}

class EntertainmentPage extends StatelessWidget {
  const EntertainmentPage({super.key});

  // sample data (replace with your images or assets)
  List<Entertainment> get workshops => [
    Entertainment(
      id: 'w1',
      title: '',
      imageUrl: 'https://ormatrix.in/tapasucon2025/Admin/workshop/entertainment1.jpg',
    ),
    Entertainment(
      id: 'w2',
      title: 'Gala Dinner',
      imageUrl: 'https://ormatrix.in/tapasucon2025/Admin/workshop/entertainment2.jpg',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Entertainment',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0072FF), // Blue
                Color(0xFF00C853), // Green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent so gradient shows
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final w = workshops[index];
          return _WorkshopCard(workshop: w);
        },
      ),
    );
  }
}

class _WorkshopCard extends StatelessWidget {
  final Entertainment workshop;
  const _WorkshopCard({required this.workshop});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'hero-${workshop.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FullImagePage(workshop: workshop),
                    ),
                  );
                },
                child: Image.network(
                  workshop.imageUrl,
                  fit: BoxFit.cover,      // fills the width, crops if needed
                  height: 600,
                  width: double.infinity, // makes image fill width
                ),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              workshop.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullImagePage extends StatelessWidget {
  final Entertainment workshop;
  const FullImagePage({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(workshop.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-${workshop.id}',
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 4,
            child: Image.network(workshop.imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
