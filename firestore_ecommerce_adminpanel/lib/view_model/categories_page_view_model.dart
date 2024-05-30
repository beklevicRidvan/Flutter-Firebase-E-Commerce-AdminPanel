import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category_model.dart';
import '../repository/database_repository.dart';
import '../tools/locator.dart';
import '../view/edit_view/user_edit_view.dart';
import '../view/product_view.dart';
import 'product_page_view_model.dart';

class CategoriesPageViewModel with ChangeNotifier {
  late Stream<List<CategoryModel>>? _stream;
  List<CategoryModel> _categories = [];
  late TextEditingController _categoryNameController;
  late TextEditingController _categoryImageController;
  late TextEditingController _updatedCategoryNameController;
  late TextEditingController _updatedCategoryImageController;

  final _repository = locator<DatabaseRepository>();

  CategoriesPageViewModel() {
    _categoryNameController = TextEditingController();
    _categoryImageController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }
  void getData() async {
    _stream = await _repository.getCategoriesData();
    _stream!.listen((event) {
      _categories = event;
      notifyListeners();
    });
  }

  void addData(BuildContext context) async {
    List<String>? result = await _goEditViewPage(context);
    if (result != null) {
      String categoryName = result[0];
      String categoryImage = result[1];
      var categoryModel = CategoryModel(
          categoryImage: categoryImage, categoryName: categoryName);
      dynamic categoryId =
          await _repository.addCategories(categoryModel: categoryModel);
      categoryModel.categoryId = categoryId;
    }
  }



  Future<List<String>?> _goEditViewPage(BuildContext context,{dynamic currentCategoryName,dynamic currentImageAdress}) async {
    _updatedCategoryNameController = TextEditingController(text: currentCategoryName ?? "");
    _updatedCategoryImageController = TextEditingController(text:  currentImageAdress ?? "");

    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CategoriesPageViewModel(),
        child: UserEditView(
          controller1: currentCategoryName != null ? _updatedCategoryNameController : _categoryNameController,
          controller2: currentImageAdress != null ? _updatedCategoryImageController : _categoryImageController,
        ),
      ),
    );
    var result = await Navigator.push(context, pageRoute);
    return result;
  }


   updateData(BuildContext context, int index) async{
    CategoryModel categoryModel = _categories[index];
    List<String>? result = await _goEditViewPage(context,currentCategoryName: categoryModel.categoryName,currentImageAdress: categoryModel.categoryImage);
    if(result != null){
      String newCategoryName = result[0];
      String newCategoryImage = result[1];
      await _repository.updateCategories(categoryModel: categoryModel, newCategoryName: newCategoryName, newCategoryImage: newCategoryImage);
    }
  }

   deleteData(int index) async{
    CategoryModel categoryModel = _categories[index];
     await _repository.deleteCategories(categoryModel: categoryModel);
  }


  List<CategoryModel> get categories => _categories;

}
