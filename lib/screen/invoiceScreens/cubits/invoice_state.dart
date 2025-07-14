import '../api/invoice_model.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}
class InvoiceLoading extends InvoiceState {}
class InvoiceLoaded extends InvoiceState {
  final List<InvoiceModel> invoices;
  InvoiceLoaded(this.invoices);
}
class InvoiceError extends InvoiceState {
  final String message;
  InvoiceError(this.message);
}
