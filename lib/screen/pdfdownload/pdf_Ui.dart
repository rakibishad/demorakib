import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfUi extends StatefulWidget {
  const PdfUi({super.key});

  @override
  State<PdfUi> createState() => _PdfUiState();
}

class _PdfUiState extends State<PdfUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                build: (context) => pw.Center(
                  child: pw.Text("Hello PDF"),
                ),
              ),
            );

            await Printing.sharePdf(
              bytes: await pdf.save(),
              filename: "example.pdf",
            );
          },
          child: const Text("Generate PDF"),
        ),
      ),
    );
  }
}
