import 'package:flutter/material.dart';

class WorkshopPage extends StatelessWidget {
  const WorkshopPage({super.key});

  final String title = "Pre-Conference Workshop";
  final String imageUrl =
      "https://ormatrix.in/tapasucon2025/Admin/workshop/preworkshop.jpg"; // replace with your image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text(title, style:TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)], // purple theme
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FullImagePage(
                    title: title,
                    imageUrl: imageUrl,
                  ),
                ));
              },
              child: Hero(
                tag: "workshop-image",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 600,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const FullImagePage({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Hero(
          tag: "workshop-image",
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 4,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
