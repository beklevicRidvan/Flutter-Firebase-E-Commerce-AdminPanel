class CategoryModel{
  dynamic categoryId;
  String categoryImage;
  String categoryName;

  CategoryModel({this.categoryId,required this.categoryImage,required this.categoryName});


  factory CategoryModel.fromMap({required Map<String,dynamic> map,dynamic key}){
    return CategoryModel(categoryId:key ?? map["categoryId"] ,categoryImage: map["categoryImage"], categoryName: map["categoryName"]);
  }

  Map<String,dynamic> toMap({required dynamic key}){
    return{
      "categoryId":key ?? categoryId,
      "categoryImage":categoryImage,
      "categoryName":categoryName
    };
  }

  Map<String,dynamic> toUpdatedMap({required String newCategoryImage,required String newCategoryName}){
    return {
      "categoryId":categoryId,
      "categoryImage":newCategoryImage,
      "categoryName":newCategoryName
    };
  }
}