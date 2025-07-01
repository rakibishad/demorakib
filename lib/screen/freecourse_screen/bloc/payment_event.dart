abstract class PaymentEvent {}

class MakePaymentEvent extends PaymentEvent {
  final String name;
  MakePaymentEvent({required this.name});
}
