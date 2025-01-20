import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

class PdfPreviewScreen extends StatefulWidget {
  final File pdfPath; // Path to the PDF file

  PdfPreviewScreen({required this.pdfPath});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      // The user denied the permission.
      // You can show a dialog or a snackbar explaining why the permission is necessary
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PDFView(
              filePath: widget.pdfPath.path,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  sharePdf(context);
                },
                icon: const Icon(Icons.share),
                label: const Text('Share PDF'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // printPdf(context);
                },
                icon: const Icon(Icons.print),
                label: const Text('Print PDF'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void sharePdf(BuildContext context) async {
    final file = File(widget.pdfPath.path);
    if (await file.exists()) {
      try {
        final sanitizedPath = file.path.replaceAll("'", '');
        await Share.shareFiles([sanitizedPath], text: 'Share PDF via');
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to share PDF: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
