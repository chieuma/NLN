class OrderModel {
  final int? orderId;
  final int userId;
  final String name;
  final String address;
  final String tel;
  final String email;
  late final String? status;
  final double total;
  final DateTime? date;
  // final String? code;

  OrderModel({
    this.orderId,
    required this.userId,
    required this.name,
    required this.address,
    required this.tel,
    required this.email,
    this.status,
    required this.total,
    this.date,
    //this.code,
  });

  static OrderModel fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      userId: json['order_user_id'],
      name: json['order_name'],
      address: json['order_address'],
      tel: json['order_sdt'],
      email: json['order_email'],
      status: json['order_status'],
      total: json['order_total_price'].toDouble(),
      date: DateTime.parse(json['order_date']),
      // code: json['order_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'name': name,
      'address': address,
      'tel': tel,
      'email': email,
      'total': total,
    };
  }
}
