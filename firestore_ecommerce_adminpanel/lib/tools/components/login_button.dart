import 'package:firestore_ecommerce_adminpanel/tools/constants.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {

       return Container(
         padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: Colors.grey.shade800,

         ),
         child: GestureDetector(
          onTap:() =>  onTap(),
          child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ADMIN LOGIN",style: Constants.getBoldStyle(fontSize: 18)),
          ],
               ),
               ),
       );

  }
}
