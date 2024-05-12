import 'dart:convert';
import 'dart:typed_data';

class UserModel {
  final int? id;
  final String name;
  final String password;
  late final String? fullName;
  late final String? email;
  late final String? address;
  late final String? tel;
  final DateTime date;
  late Uint8List? image;
  final String role;

  UserModel(
      {this.id,
      required this.name,
      required this.password,
      this.fullName,
      this.email,
      this.address,
      this.tel,
      required this.date,
      this.image,
      required this.role});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'fullName': fullName,
      'email': email,
      'address': address,
      'tel': tel,
      'date': date.toIso8601String(),
      'image': image,
      'role': role,
    };
  }

  Map<String, dynamic> toJsonEditProfile() {
    return {
      'id': id,
      'name': name,
      'fullName': fullName,
      'email': email,
      'address': address,
      'tel': tel,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    String? imageData = json['user_image'];
    Uint8List? imageBytes;
    if (imageData != null) {
      imageBytes = base64Decode(imageData);
    } else {
      imageBytes = null;
    }
    return UserModel(
      id: json['user_id'],
      name: json['user_username'],
      password: json['user_password'],
      fullName: json['user_full_name'],
      email: json['user_email'],
      address: json['user_address'],
      tel: json['user_tel'],
      date: DateTime.parse(json['user_date']),
      image: imageBytes,
      role: json['user_role'],
    );
  }
}
