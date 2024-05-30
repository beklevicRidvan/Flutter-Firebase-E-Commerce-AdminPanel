class ProductModel{
  dynamic productId;
  String productName;
  String productImage;
  dynamic productPrice;
  dynamic productCategoryId;

  ProductModel({this.productId,required this.productName,required this.productImage,required this.productPrice,this.productCategoryId});



  factory ProductModel.fromMap({required Map<String,dynamic>map,dynamic productKey,dynamic categoryKey}){
    return ProductModel(productId: productKey ?? map["productId"],productName: map["productName"], productImage: map["productImage"], productPrice: map["productPrice"],productCategoryId:categoryKey ?? map["categoryKey"] );
  }


  Map<String,dynamic> toMap({required dynamic productKey,required dynamic productCategoryKey}){
    return {
      "productId":productKey ?? productId,
      "productName":productName,
      "productImage":productImage,
      "productPrice":productPrice,
      "productCategoryId":productCategoryKey ?? productCategoryId
    };
  }


  Map<String,dynamic> toUpdatedMap({required String newProductName,required String  newProductImage,required dynamic newProductPrice}){
    return {
      "productId":productId,
      "productName":newProductName,
      "productImage":newProductImage,
      "productPrice":newProductPrice,
      "productCategoryId":productCategoryId
    };
  }

}