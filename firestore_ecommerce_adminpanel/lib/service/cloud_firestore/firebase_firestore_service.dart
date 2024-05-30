import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../model/admin_model.dart';
import '../../model/category_model.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../database_service.dart';

class FirebaseFirestoreService extends DatabaseBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future addCategories({required CategoryModel categoryModel}) async {
    dynamic categoryId = _firestore.collection("categories").doc().id;
    return await _firestore
        .doc("categories/$categoryId")
        .set(categoryModel.toMap(key: categoryId));
  }

  @override
  Future addProduct(
      {required ProductModel productModel, required dynamic categoryId}) async {
    dynamic productId = _firestore
        .doc("categories/$categoryId")
        .collection("products")
        .doc()
        .id;
    return await _firestore
        .doc("categories/$categoryId")
        .collection("products")
        .doc(productId)
        .set(productModel.toMap(
            productKey: productId, productCategoryKey: categoryId));
  }

  @override
  Future addUser({required UserModel userModel}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: userModel.userEmail, password: "123456");
      dynamic userId = user.user!.uid;
      dynamic basketId =
          _firestore.doc("users/$userId").collection("basket").doc().id;
      dynamic favoriteId =
          _firestore.doc("users/$userId").collection("favorites").doc().id;
      var favoriteQuery = await _firestore
          .doc("users/$userId")
          .collection("favorites")
          .doc(favoriteId)
          .set({"favoriteId": favoriteId});
      var basketQuery = await _firestore
          .doc("users/$userId")
          .collection("basket")
          .doc(basketId)
          .set({"basketId": basketId}).whenComplete(() => favoriteQuery);

      return await _firestore
          .collection("users")
          .doc(userId)
          .set(userModel.toMap(userKey: userId))
          .whenComplete(() => basketQuery);
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future deleteCategories({required CategoryModel categoryModel}) async {
    try {
      await _firestore.doc("categories/${categoryModel.categoryId}").delete();
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future deleteProduct(
      {required ProductModel productModel, required dynamic categoryId}) async {
    try {
      await _firestore
          .doc("categories/$categoryId")
          .collection("products")
          .doc("${productModel.productId}")
          .delete();
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future deleteUser({required UserModel userModel}) async {
    try {

        await _firestore.doc("users/${userModel.userId}").delete();



    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future getCategoriesData() async {
    try {
      return _firestore
          .collection("categories")
          .orderBy("categoryName")
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((e) => CategoryModel.fromMap(map: e.data(), key: e.id))
              .toList());
    } catch (e) {
      debugPrint("Bir hata meydana geldi: $e");
    }
  }

  @override
  Future getProductData({required categoryId}) async {
    try {
      return _firestore
          .doc("categories/$categoryId")
          .collection("products")
          .orderBy("productName")
          .snapshots()
          .map((event) => event.docs
              .map((e) => ProductModel.fromMap(
                  map: e.data(), productKey: e.id, categoryKey: categoryId))
              .toList());
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future getUsersData() async {
    try {
      return _firestore.collection("users").orderBy("userName").snapshots().map(
          (snapshots) => snapshots.docs
              .map((e) => UserModel.fromMap(map: e.data(), key: e.id))
              .toList());
    } catch (e) {
      debugPrint("Bir hata meydana geldi: $e");
    }
  }

  @override
  Future updateCategories(
      {required CategoryModel categoryModel,
      required String newCategoryName,
      required String newCategoryImage}) async {
    try {
      await _firestore.doc("categories/${categoryModel.categoryId}").update(
          categoryModel.toUpdatedMap(
              newCategoryImage: newCategoryImage,
              newCategoryName: newCategoryName));
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future updateProduct(
      {required ProductModel productModel,
      required dynamic categoryId,
      required String newProductName,
      required String newProductImage,
      required dynamic newProductPrice}) async {
    try {
      await _firestore
          .doc("categories/$categoryId")
          .collection("products")
          .doc(productModel.productId)
          .update(productModel.toUpdatedMap(
              newProductName: newProductName,
              newProductImage: newProductImage,
              newProductPrice: newProductPrice));
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future updateUser(
      {required UserModel userModel,
      required String newUserName,
      required String newUserEmail}) async {
    try {
      await _firestore.doc("users/${userModel.userId}").update(userModel
          .toUpdatedMap(newUserName: newUserName, newUserEmail: newUserEmail));
    } catch (e) {
      debugPrint("Bir hata oluştu: $e");
    }
  }

  @override
  Future getCategoriesCount() async {
    try {
      var collectionRef = await _firestore.collection("categories").get();
      var maps = collectionRef.docs;
      return maps.length;
    } catch (e) {
      debugPrint("Bir hata meydana geldi: $e");
    }
  }

  @override
  Future getUsersCount() async {
    try {
      var collectionRef = await _firestore.collection("users").get();
      var maps = collectionRef.docs;
      return maps.length;
    } catch (e) {
      debugPrint("Bir hata meydana geldi $e");
    }
  }

  @override
  Stream<List<AdminModel>> getAdmin()  {
    try {
      User? currentUser = _auth.currentUser;

        var currentAdminID = currentUser!.uid;
        return  _firestore.collection("admin").where("adminId",isEqualTo:currentAdminID).snapshots().map((event) => event.docs.map((e) => AdminModel.fromMap(map: e.data(),key: e.id)).toList());


    } catch (e) {
      throw Exception(e);
    }
  }
}
