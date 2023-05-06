 class SocialUserModel {
  String? name;
  String? email;
  String? location;
  //String? image;
  String? bio;
  String? uId;
  
  SocialUserModel({
    this.email,
    this.name,
    this.location,
   // this.image,
    this.bio,
    this.uId,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json)
  {
    email = json!['email'];
    name = json['name'];
   location = json['location'];
    //image = json['image'];
    bio = json['bio'];
    uId = json['uId'];
    
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'location':location,
      //'image':image,
      'bio':bio,
      'uId':uId,
    };
  }
  }