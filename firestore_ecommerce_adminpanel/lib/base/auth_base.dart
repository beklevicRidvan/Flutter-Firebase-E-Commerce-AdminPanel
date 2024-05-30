import '../model/admin_model.dart';

abstract class AuthBase{
  Future<dynamic> loginWithAdmin(String email,String password,AdminModel admin);
  Future<dynamic> logOut();
}