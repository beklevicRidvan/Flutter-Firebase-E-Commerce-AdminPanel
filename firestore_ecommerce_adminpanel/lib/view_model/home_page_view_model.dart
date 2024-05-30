import 'package:firestore_ecommerce_adminpanel/model/admin_model.dart';
import 'package:flutter/material.dart';

import '../repository/database_repository.dart';
import '../tools/locator.dart';

class HomePageViewModel with ChangeNotifier {
  int _userCount = 0;
  int _categoryCount = 0;
  final _repository = locator<DatabaseRepository>();
  int get userCount => _userCount;

  int get categoryCount => _categoryCount;

  HomePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserCount();

      getCategoriesCount();
    });
  }

  Stream<List<AdminModel>> getAdmin()  {
    return  _repository.getAdmin();
  }

  void getUserCount() async {
    _userCount = await _repository.getUsersCount();
    notifyListeners();
  }

  void getCategoriesCount() async {
    _categoryCount = await _repository.getCategoriesCount();
    notifyListeners();
  }

  void logOut() async {
    await _repository.logOut();
  }
}
