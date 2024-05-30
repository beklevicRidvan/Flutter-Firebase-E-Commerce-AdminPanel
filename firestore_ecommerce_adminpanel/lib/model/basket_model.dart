class BasketModel {
  dynamic basketId;

  BasketModel({required this.basketId});

  factory BasketModel.fromMap(
      {required Map<String, dynamic> map, dynamic key}) {
    return BasketModel(basketId: key ?? map["basketId"]);
  }


  Map<String,dynamic> toMap({dynamic key}){
    return {
      "basketId":key ?? basketId
    };
  }
}
