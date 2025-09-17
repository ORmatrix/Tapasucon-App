import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryPage extends StatelessWidget {
 // final String qrUrl = "https://drive.google.com/drive/folders/14CD2vSE1p_Ort2ayqaXzeHkJnqtsjW5R"; // 👈 your link

  final String qrUrl = "https://drive.google.com/drive/folders/14CD2vSE1p_Ort2ayqaXzeHkJnqtsjW5R";
  const GalleryPage({super.key});

  Future<void> _openLink() async {
    final Uri uri = Uri.parse(qrUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $qrUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code
            QrImageView(
              data: qrUrl,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openLink,
              icon: const Icon(Icons.open_in_browser),
              label: const Text("Open Link Now"),
            ),
          ],
        ),
      ),
    );
  }
}
