import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'api/invoice_model.dart';
import 'cubits/invoice_cubit.dart';



class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  Future<Uint8List> generateInvoicePdf(InvoiceModel invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice #: ${invoice.id}', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 8),
              pw.Text('Date: ${invoice.date}'),
              pw.Text('Customer: ${invoice.customerName}'),
              pw.Text('Country: ${invoice.country}'),
              pw.SizedBox(height: 12),
              pw.Text('Amount: ₹${invoice.amount.toStringAsFixed(2)}'),
              pw.Text('VAT (${invoice.vatRate}%): ₹${invoice.vatAmount.toStringAsFixed(2)}'),
              pw.Text('Total: ₹${invoice.totalAmount.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }

  Future<void> uploadInvoicePdf(Uint8List pdfData, String fileName) async {
    final ref = FirebaseStorage.instance.ref().child('invoices/$fileName.pdf');
    await ref.putData(pdfData);
  }

  void generateAndUpload(BuildContext context) async {
    final now = DateTime.now();
    final invoice = InvoiceModel(
      id: 'INV-${now.millisecondsSinceEpoch}',
      customerName: 'Rakib Shaikh',
      country: 'India',
      amount: 1000,
      vatRate: 18,
      vatAmount: 1000 * 0.18,
      totalAmount: 1000 + 1000 * 0.18,
      date: DateFormat('yyyy-MM-dd').format(now),
    );

    context.read<InvoiceCubit>().createInvoice(invoice);

    final pdfData = await generateInvoicePdf(invoice);
    await uploadInvoicePdf(pdfData, invoice.id);
    await Printing.layoutPdf(onLayout: (_) => pdfData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice Management')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => generateAndUpload(context),
          child: const Text('Generate & Download Invoice'),
        ),
      ),
    );
  }
}
