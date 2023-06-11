class PurchasedModel {
  final int? id;
  final String? date;
  final String? customer;
  final double? amount;
  final List<dynamic> products;
  final String? address;

  PurchasedModel(
      {this.id,
      this.date,
      this.customer,
      this.amount,
      required this.products,
      this.address});

  factory PurchasedModel.fromJson(Map<String, dynamic> json) {
    return PurchasedModel(
        date: json['date'],
        customer: json['customer'],
        amount: json['amount'],
        products: json['products'],
        id: json['id'],
        address: json['address']);
  }
}
