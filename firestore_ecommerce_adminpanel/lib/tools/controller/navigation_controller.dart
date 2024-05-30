import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view/categories_page_view.dart';
import '../../view/product_view.dart';
import '../../view/users_page_view.dart';
import '../../view_model/categories_page_view_model.dart';
import '../../view_model/product_page_view_model.dart';
import '../../view_model/users_page_view_model.dart';

mixin NavigationController on StatelessWidget{
  void goUsersPage({required BuildContext context}){
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => UsersPageViewModel(),child: const UsersPageView(),),);
    Navigator.push(context, pageRoute);
  }

  void goCategoriesPage({required BuildContext context}){
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => CategoriesPageViewModel(),child: const CategoriesPageView(),),);
    Navigator.push(context, pageRoute);
  }

  void goProductPage(BuildContext context, category) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ProductPageViewModel(category: category),
        child: const ProductPageView(),
      ),
    );
    Navigator.push(context, pageRoute);
  }
}