import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/admin_model.dart';
import '../authbase_base_service.dart';

class AuthService extends AuthBaseBaseService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Future logOut() async {
    await _auth.signOut();

  }

  @override
  Future loginWithAdmin(String email, String password, AdminModel admin) async {
    var element = await _firestore
        .collection("admin")
        .where("adminEmail", isEqualTo: email)
        .get();
    if (element.docs.isNotEmpty) {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user!.uid;
    } else {
      return throw Exception("ADMİN DEĞİLSİNİZ PANELE GİRİŞ YAPAMAZSINIZ");
    }
  }
}
