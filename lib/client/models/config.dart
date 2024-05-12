import 'dart:math';

class ConfigModel {
  int? id;
  String? screen;
  String? chip;
  String? ram;
  String? frontCamera;
  String? rearCamera;
  String? pin;
  String? jackPhone;
  String? bluetooth;
  String? opSystem;
  late int pdId;

  ConfigModel({
    this.id,
    this.screen,
    this.chip,
    this.ram,
    this.frontCamera,
    this.rearCamera,
    this.pin,
    this.jackPhone,
    this.bluetooth,
    this.opSystem,
    required this.pdId,
  });

  static ConfigModel fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      id: json['config_id'],
      screen: json['config_screen'],
      chip: json['config_chip'],
      ram: json['config_ram'],
      frontCamera: json['config_camera_front'],
      rearCamera: json['config_camera_rear'],
      pin: json['config_pin'],
      jackPhone: json['config_jackphone'],
      bluetooth: json['config_bluetooth'],
      opSystem: json['config_opsystem'],
      pdId: json['config_pd_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'screen': screen,
      'chip': chip,
      'ram': ram,
      'frontCamera': frontCamera,
      'rearCamera': rearCamera,
      'pin': pin,
      'jackphone': jackPhone,
      'bluetooth': bluetooth,
      'opSystem': opSystem,
      'pdId': pdId,
    };
  }
}
