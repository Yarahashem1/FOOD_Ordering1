class UserModel {
  late final String userName;
  late final String userEmail;


  UserModel({
    required this.userName,
    required this.userEmail,
  });

    UserModel.fromJson(Map<String, dynamic>? json)
  {
    userName = json!['name'];
    userEmail = json['email'];
  

    
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':userName,
      'email':userEmail,
     
    };
  
    
}
}