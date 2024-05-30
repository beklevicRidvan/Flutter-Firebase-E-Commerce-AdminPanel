import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category_model.dart';
import '../tools/constants.dart';
import '../tools/controller/navigation_controller.dart';
import '../view_model/categories_page_view_model.dart';

class CategoriesPageView extends StatelessWidget with NavigationController{
  const CategoriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriesPageViewModel viewModel =
        Provider.of<CategoriesPageViewModel>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: Constants.buildFloatingActionButton(() {
        viewModel.addData(context);
      }),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("Kategoriler"),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<CategoriesPageViewModel>(
      builder: (context, value, child) {
        debugPrint("category consumer çalıştı");

        if (value.categories.isNotEmpty) {
          return GridView.builder(
            itemCount: value.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 300),
            itemBuilder: (context, index) {
              var currentElement = value.categories[index];
              return _buildListItem(context, index, currentElement);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Constants.circularProgressIndicatorColor,
            ),
          );
        }
      },
    );
  }

  _buildListItem(BuildContext context, int index, CategoryModel category) {
    CategoriesPageViewModel viewModel = Provider.of(context, listen: false);

    List<VoidCallback> funcList = [
      () => viewModel.updateData(context, index),
      () => viewModel.deleteData(index)
    ];

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
           goProductPage(context, category);
          },
          child: Card(
            margin: Constants.getLittlePadding(),
            elevation: 3,
            shadowColor: Colors.white,
            child: Column(
              children: [
                Image(
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                  image: NetworkImage(category.categoryImage),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : Image.asset(
                              Constants.placeHolderImageAdress,
                              fit: BoxFit.cover,
                              height: 200,
                              width: 200,
                            ),
                ),
                Padding(
                  padding: Constants.getNormalPadding(),
                  child: Text(
                    category.categoryName,
                    style: Constants.getBoldStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: 0, top: 0, child: Constants.buildPopMenu(context, funcList)),
      ],
    );
  }
}
