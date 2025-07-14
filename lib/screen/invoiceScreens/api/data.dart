import 'package:cloud_firestore/cloud_firestore.dart';

import 'invoice_model.dart';

class InvoiceRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addInvoice(InvoiceModel invoice) async {
    await firestore.collection('invoices').doc(invoice.id).set(invoice.toMap());
  }

  Stream<List<InvoiceModel>> fetchInvoices() {
    return firestore.collection('invoices').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => InvoiceModel.fromMap(doc.data())).toList(),
    );
  }
}
