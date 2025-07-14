class InvoiceModel {
  final String id;
  final String customerName;
  final String country;
  final double amount;
  final double vatRate;
  final double vatAmount;
  final double totalAmount;
  final String date;

  InvoiceModel({
    required this.id,
    required this.customerName,
    required this.country,
    required this.amount,
    required this.vatRate,
    required this.vatAmount,
    required this.totalAmount,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'customerName': customerName,
    'country': country,
    'amount': amount,
    'vatRate': vatRate,
    'vatAmount': vatAmount,
    'totalAmount': totalAmount,
    'date': date,
  };

  factory InvoiceModel.fromMap(Map<String, dynamic> map) => InvoiceModel(
    id: map['id'],
    customerName: map['customerName'],
    country: map['country'],
    amount: map['amount'],
    vatRate: map['vatRate'],
    vatAmount: map['vatAmount'],
    totalAmount: map['totalAmount'],
    date: map['date'],
  );
}
