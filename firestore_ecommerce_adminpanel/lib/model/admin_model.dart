class AdminModel {
  dynamic adminId;
  String adminEmail;

  AdminModel({this.adminId, required this.adminEmail});

  factory AdminModel.fromMap({required Map<String, dynamic> map, dynamic key}) {
    return AdminModel(
        adminId: key ?? map["adminId"], adminEmail: map["adminEmail"]);
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      "adminId": key ?? adminId,
      "adminEmail": adminEmail,
    };
  }
}
