
import '../base/auth_base.dart';
import '../base/database_base.dart';
import '../model/admin_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';
import '../service/auth/auth_service.dart';
import '../service/cloud_firestore/firebase_firestore_service.dart';
import '../tools/locator.dart';

class DatabaseRepository implements DatabaseBase,AuthBase {
  final _service = locator<FirebaseFirestoreService>();
  final _authService = locator<AuthService>();

  @override
  Future addCategories({required CategoryModel categoryModel}) async {
    return await _service.addCategories(categoryModel: categoryModel);
  }

  @override
  Future addProduct(
      {required ProductModel productModel, required dynamic categoryId}) async {
    return await _service.addProduct(
        productModel: productModel, categoryId: categoryId);
  }

  @override
  Future addUser({required UserModel userModel}) async {
    return await _service.addUser(userModel: userModel);
  }

  @override
  Future deleteCategories({required CategoryModel categoryModel}) async {
    await _service.deleteCategories(categoryModel: categoryModel);
  }

  @override
  Future deleteProduct(
      {required ProductModel productModel, required dynamic categoryId}) async {
    await _service.deleteProduct(
        productModel: productModel, categoryId: categoryId);
  }

  @override
  Future deleteUser({required UserModel userModel}) async {
    await _service.deleteUser(userModel: userModel);
  }

  @override
  Future getCategoriesData() async {
    return await _service.getCategoriesData();
  }

  @override
  Future getProductData({required categoryId}) async {
    return await _service.getProductData(categoryId: categoryId);
  }

  @override
  Future getUsersData() async {
    return await _service.getUsersData();
  }

  @override
  Future updateCategories(
      {required CategoryModel categoryModel,
      required String newCategoryName,
      required String newCategoryImage}) async {
    await _service.updateCategories(
        categoryModel: categoryModel,
        newCategoryImage: newCategoryImage,
        newCategoryName: newCategoryName);
  }

  @override
  Future updateProduct(
      {required ProductModel productModel,
      required dynamic categoryId,
      required String newProductName,
      required String newProductImage,
      required dynamic newProductPrice}) async {
    await _service.updateProduct(
        productModel: productModel,
        categoryId: categoryId,
        newProductName: newProductName,
        newProductImage: newProductImage,
        newProductPrice: newProductPrice);
  }

  @override
  Future updateUser(
      {required UserModel userModel,
      required String newUserName,
      required String newUserEmail}) async {
    await _service.updateUser(
        userModel: userModel,
        newUserName: newUserName,
        newUserEmail: newUserEmail);
  }

  @override
  Future getCategoriesCount() async {
    return await _service.getCategoriesCount();
  }

  @override
  Future getUsersCount() async {
    return await _service.getUsersCount();
  }

  @override
  Future logOut() async{
    await _authService.logOut();
  }

  @override
  Future loginWithAdmin(String email, String password,AdminModel admin) async{
    return await _authService.loginWithAdmin(email, password,admin);
  }

  @override
  Stream<List<AdminModel>> getAdmin() {
    return  _service.getAdmin();
  }
}
