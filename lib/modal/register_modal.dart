import 'dart:io';

class RegisterModal {
  String name;
  String mobile;
  String address;
  String visitorName;
  String dateTime;
  String purpose;
  String imagePath;

  RegisterModal({
    required this.name,
    required this.mobile,
    required this.address,
    required this.visitorName,
    required this.dateTime,
    required this.purpose,
    required this.imagePath
  });

  factory RegisterModal.fromJson(Map<String, dynamic> json) {
    return RegisterModal(
      name: json['Name'] ?? '',
      mobile: json['Mobile'] ?? '',
      address: json['Address'] ?? '',
      visitorName: json['Visitor_name'] ?? '',
      dateTime: json['Date_time'] ?? '',
      purpose: json['Purpose'] ?? '',
      imagePath: json['Image']
    );
  }

}
