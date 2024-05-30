import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';
import '../view/edit_view/user_edit_view.dart';

class UsersPageViewModel with ChangeNotifier {
  late Stream<List<UserModel>>? _stream;
  List<UserModel> _users = [];

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  late TextEditingController _updatedNameController;
  late TextEditingController _updatedEmailController;

  final _repository = locator<DatabaseRepository>();

  UsersPageViewModel() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async {
    _stream = await _repository.getUsersData();
    _stream!.listen((event) {
      _users = event;
      notifyListeners();
    });
  }

  void addUser(BuildContext context) async {
    List<String>? result = await goEditPageView(context);
    if (result != null) {
      String newName = result[0];
      String newEmail = result[1];
      UserModel newUser = UserModel(userEmail: newEmail, userName: newName);
      dynamic userId = await _repository.addUser(userModel: newUser);
      newUser.userId = userId;
    }
  }

  void deleteData(int index) async {
    await _repository.deleteUser(userModel: _users[index]);
  }

  void updateData(BuildContext context, int index) async {
    UserModel userModel = _users[index];

    List<String>? result = await goEditPageView(context,currentUserEmail: userModel.userEmail,currentUserName: userModel.userName);
    if(result != null){
      String newUserName = result[0];
      String newUserEmail = result[1];
      await _repository.updateUser(userModel: userModel, newUserName: newUserName, newUserEmail: newUserEmail);
    }
  }

  Future<List<String>?> goEditPageView(BuildContext context,
      {dynamic currentUserName, dynamic currentUserEmail}) async {
    _updatedNameController = TextEditingController(text: currentUserName ?? "");
    _updatedEmailController = TextEditingController(text: currentUserEmail ?? "");
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => UsersPageViewModel(),
        child: UserEditView(
            controller1: currentUserName != null ? _updatedNameController :_nameController,
            controller2: currentUserEmail != null ? _updatedEmailController : _emailController),
      ),
    );
    var result = await Navigator.push(context, pageRoute);
    return result;
  }

  List<UserModel> get users => _users;
}
