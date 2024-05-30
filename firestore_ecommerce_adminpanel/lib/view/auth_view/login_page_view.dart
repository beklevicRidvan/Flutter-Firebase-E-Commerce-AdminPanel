import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tools/components/login_button.dart';
import '../../tools/components/my_textfield.dart';
import '../../view_model/login_page_view_model.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    LoginPageViewModel viewModel = Provider.of(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CircleAvatar(radius: 60,backgroundColor: Colors.grey.shade800,child:const Icon(Icons.person,size: 80,color: Colors.white,),),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: MyTextField(
              controller: viewModel.emailController,
              text: "Input mail",
              obscureValue: false,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: MyTextField(
              controller: viewModel.passwordController,
              text: "Input password",
              obscureValue: true,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
           child: LoginButton(onTap:() => viewModel.login(context)),
         ),
        ],
      ),
    );
  }
}
