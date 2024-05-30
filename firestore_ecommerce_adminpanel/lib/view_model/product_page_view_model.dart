import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';
import '../view/edit_view/user_edit_view.dart';

class ProductPageViewModel with ChangeNotifier {
  late Stream<List<ProductModel>> _stream;
  late StreamSubscription<List<ProductModel>> _subscription;
  List<ProductModel> _products = [];

  late TextEditingController _productNameController;
  late TextEditingController _productImageController;
  late TextEditingController _productPriceController;

  late TextEditingController _updatedProductNameController;
  late TextEditingController _updatedProductImageController;
  late TextEditingController _updatedProductPriceController;


  final CategoryModel category;

  final _repository = locator<DatabaseRepository>();

  ProductPageViewModel({required this.category}) {
    _productNameController = TextEditingController();
    _productImageController = TextEditingController();
    _productPriceController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async {
    _stream = await _repository.getProductData(categoryId: category.categoryId);
    _subscription = _stream.listen((event) {
      _products = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void addData(BuildContext context) async {
    List<dynamic>? result = await goEditPageView(context);
    if (result != null) {
      String productName = result[0];
      String productImage = result[1];
      double price;
      dynamic productPrice = result[2];

      if (productPrice.contains(".")) {
        price = double.parse(productPrice);
      } else {
        price = int.parse(productPrice).toDouble();
      }

      ProductModel productModel = ProductModel(
          productName: productName,
          productImage: productImage,
          productPrice: price);
      dynamic productId = await _repository.addProduct(
          productModel: productModel, categoryId: category.categoryId);
      productModel.productId = productId;
    }
  }


  updateData(BuildContext context, int index) async{
    ProductModel productModel = _products[index];
    List<dynamic>? result= await goEditPageView(context,currentProductName: productModel.productName,currentProductImage: productModel.productImage,currentProductPrice: productModel.productPrice);
    if(result != null){
      String newProductName = result[0];
      String newProductImage = result[1];
      double price;
      dynamic productPrice = result[2];

      if (productPrice.contains(".")) {
        price = double.parse(productPrice);
      } else {
        price = int.parse(productPrice).toDouble();
      }
      await _repository.updateProduct(productModel: productModel, categoryId: category.categoryId, newProductName: newProductName, newProductImage: newProductImage, newProductPrice: price);

    }
  }

  deleteData(int index) async{
    ProductModel productModel = _products[index];
    await _repository.deleteProduct(productModel: productModel, categoryId: category.categoryId);
  }

  Future<List<dynamic>?> goEditPageView(BuildContext context,{dynamic currentProductName,dynamic currentProductImage,dynamic currentProductPrice}) async {
    _updatedProductNameController = TextEditingController(text: currentProductName ?? "");
    _updatedProductImageController = TextEditingController(text: currentProductImage ?? "");
    _updatedProductPriceController = TextEditingController(text: currentProductPrice.toString() ?? "");
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ProductPageViewModel(category: category),
        child: UserEditView(
          controller1: currentProductName != null ? _updatedProductNameController : _productNameController,
          controller2: currentProductImage != null ? _updatedProductImageController : _productImageController,
          controller3: currentProductPrice != null ? _updatedProductPriceController : _productPriceController,
        ),
      ),
    );
    var result = await Navigator.push(context, pageRoute);
    return result;
  }




  List<ProductModel> get products => _products;


}
