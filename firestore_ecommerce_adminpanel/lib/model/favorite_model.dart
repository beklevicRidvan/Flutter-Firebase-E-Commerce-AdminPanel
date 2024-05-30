class FavoriteModel{
  dynamic favoriteId;

  FavoriteModel({required this.favoriteId});

  factory FavoriteModel.fromMap({required Map<String,dynamic>map,dynamic key}){
  return FavoriteModel(favoriteId: key ?? map["favoriteId"]);
  }

  Map<String,dynamic> toMap({dynamic key}){
    return {
      "favoriteId":key ?? favoriteId
    };
  }
}