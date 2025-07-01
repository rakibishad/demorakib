import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/payment_bloc.dart';
import 'bloc/payment_event.dart';
import 'bloc/payment_state.dart';


class FreeCourseUi extends StatefulWidget {
  const FreeCourseUi({super.key});

  @override
  State<FreeCourseUi> createState() => _FreeCourseUiState();
}

class _FreeCourseUiState extends State<FreeCourseUi> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  String cardType = "";

  void detectCardType(String number) {
    if (number.startsWith('4')) {
      setState(() => cardType = 'visa');
    } else if (number.startsWith('5')) {
      setState(() => cardType = 'mastercard');
    } else {
      setState(() => cardType = '');
    }
  }

  void clearFields() {
    nameController.clear();
    cardNumberController.clear();
    expiryController.clear();
    cvvController.clear();
    setState(() => cardType = '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(
        onPaymentSuccess: (paymentId) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("✅ Payment Success"),
              content: Text("Payment ID: $paymentId"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearFields();
                  },
                  child: const Text("OK"),
                )
              ],
            ),
          );
        },
        onPaymentError: (error) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("❌ Payment Failed"),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                )
              ],
            ),
          );
        },
      ),
      child: Scaffold(

        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          title: const Text("Card Payment",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            // Dialogs handled in PaymentBloc constructor
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your card details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 25),
                      buildTextField("Cardholder Name", nameController),
                      const SizedBox(height: 20),
                      buildCardNumberField(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField("MM/YYY", expiryController,
                                inputType: TextInputType.datetime),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: buildTextField("CVV", cvvController,
                                inputType: TextInputType.number),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty ||
                                cardNumberController.text.isEmpty ||
                                expiryController.text.isEmpty ||
                                cvvController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please fill all fields")),
                              );
                              return;
                            }
                            context
                                .read<PaymentBloc>()
                                .add(MakePaymentEvent(name: nameController.text));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: state is PaymentLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "Pay Now",
                            style:
                            TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCardNumberField() {
    return TextField(
      controller: cardNumberController,
      keyboardType: TextInputType.number,
      onChanged: detectCardType,
      decoration: InputDecoration(
        labelText: "Card Number",
        labelStyle: const TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: cardType == 'visa'
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.credit_card, size: 32, color: Colors.blue),
        )
            : cardType == 'mastercard'
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.credit_card, size: 32, color: Colors.red),
        )
            : Container(), // default/fallback

      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
