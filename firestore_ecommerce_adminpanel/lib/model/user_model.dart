class UserModel{
  dynamic userId;
  String userName;
  String userEmail;

  UserModel({this.userId,required this.userEmail,required this.userName});

  factory UserModel.fromMap({required Map<String,dynamic>map,dynamic key}){
    return UserModel(userId: key ?? map["userId"],userEmail: map["userEmail"], userName: map["userName"] ?? "statik");
  }


  Map<String,dynamic> toMap({dynamic userKey}){
    return {
      "userId":userKey ?? userId,
      "userName":userName,
      "userEmail":userEmail
    };
  }

  Map<String,dynamic> toUpdatedMap({required String newUserName,required String newUserEmail}){
    return  {
      "userId":userId,
      "userName":newUserName,
      "userEmail":newUserEmail
    };
  }
}