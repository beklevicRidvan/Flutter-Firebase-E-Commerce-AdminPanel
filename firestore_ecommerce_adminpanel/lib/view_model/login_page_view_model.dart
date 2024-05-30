import 'package:firestore_ecommerce_adminpanel/model/admin_model.dart';
import 'package:flutter/material.dart';

import '../repository/database_repository.dart';
import '../tools/locator.dart';

class LoginPageViewModel with ChangeNotifier {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _repository = locator<DatabaseRepository>();

  LoginPageViewModel() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  TextEditingController get passwordController => _passwordController;

  TextEditingController get emailController => _emailController;

  void login(BuildContext context) async {
    try {
      AdminModel admin = AdminModel(adminEmail: _emailController.text);
      dynamic adminID = await _repository.loginWithAdmin(
          _emailController.text, _passwordController.text, admin);
      print(adminID.toString());
      admin.adminId = adminID;
      _emailController.clear();
      _passwordController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
}
