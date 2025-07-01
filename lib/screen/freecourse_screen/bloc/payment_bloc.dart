import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final void Function(String paymentId) onPaymentSuccess;
  final void Function(String error) onPaymentError;

  late Razorpay _razorpay;

  PaymentBloc({
    required this.onPaymentSuccess,
    required this.onPaymentError,
  }) : super(PaymentInitial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // ✅ Register the event handler
    on<MakePaymentEvent>((event, emit) => _onMakePayment(event, emit));
  }

  // ✅ Define the missing _onMakePayment function
  Future<void> _onMakePayment(
      MakePaymentEvent event,
      Emitter<PaymentState> emit,
      ) async {
    emit(PaymentLoading());

    var options = {
      'key': 'rzp_test_YourKeyHere', // Replace with your Razorpay test key
      'amount': 100, // Amount in paise (₹1.00 = 100)
      'name': event.name,
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    onPaymentSuccess(response.paymentId!);
  }

  void _handleError(PaymentFailureResponse response) {
    onPaymentError(response.message ?? "Unknown error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Optional: handle wallet
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}


