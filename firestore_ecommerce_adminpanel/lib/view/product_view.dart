import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../tools/constants.dart';
import '../view_model/product_page_view_model.dart';

class ProductPageView extends StatelessWidget {
  const ProductPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductPageViewModel viewModel =
        Provider.of<ProductPageViewModel>(context, listen: false);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton:
          Constants.buildFloatingActionButton(() => viewModel.addData(context)),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title:  Text("${Provider.of<ProductPageViewModel>(context).category.categoryName} ürünleri"),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<ProductPageViewModel>(
      builder: (context, value, child) {
        if (value.products.isNotEmpty) {
          return GridView.builder(
            itemCount: value.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 320),
            itemBuilder: (context, index) {
              var currentElement = value.products[index];
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

  _buildListItem(BuildContext context, int index, ProductModel currentElement) {
    ProductPageViewModel viewModel =
        Provider.of<ProductPageViewModel>(context, listen: false);
    List<VoidCallback> funcList = [
      () => viewModel.updateData(context, index),
      () => viewModel.deleteData(index)
    ];
    return Stack(
      children: [
        Card(
              margin: Constants.getLittlePadding(),
              elevation: 3,
              shadowColor: Colors.white,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        image: NetworkImage(currentElement.productImage),
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : Image.asset(Constants.placeHolderImageAdress),
                      ),
                      Text(
                        Constants.getSpliceWord(currentElement.productName),
                        style: Constants.getNormalStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: Constants.getLittlePadding(),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${currentElement.productPrice.runtimeType == int ? currentElement.productPrice.toString() : currentElement.productPrice.toStringAsFixed(2)} TL",
                            style: Constants.getBoldStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),

        Positioned(right: 0,top: 0,child: Constants.buildPopMenu(context, funcList)),
      ],
    );
  }

/*
  List<VoidCallback> onEvents(BuildContext context,int index){
    ProductPageViewModel viewModel = Provider.of<ProductPageViewModel>(context,listen: false);
    return [
    ];
  }

 */
}
