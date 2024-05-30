import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ecommerce_adminpanel/view/auth_view/login_page_view.dart';
import 'package:firestore_ecommerce_adminpanel/view/home_page_view.dart';
import 'package:flutter/material.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {

     return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePageView();

          } else {
            return const LoginPageView();
          }
        },
      );

  }
}
