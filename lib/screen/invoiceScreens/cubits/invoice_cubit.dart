import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/data.dart';
import '../api/invoice_model.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepository repository;

  InvoiceCubit(this.repository) : super(InvoiceInitial());

  void loadInvoices() {
    emit(InvoiceLoading());
    repository.fetchInvoices().listen((invoices) {
      emit(InvoiceLoaded(invoices));
    }, onError: (e) {
      emit(InvoiceError(e.toString()));
    });
  }

  Future<void> createInvoice(InvoiceModel invoice) async {
    try {
      emit(InvoiceLoading());
      await repository.addInvoice(invoice);
      loadInvoices();
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }
}
