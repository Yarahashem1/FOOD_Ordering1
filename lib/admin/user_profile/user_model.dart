class UserModel {
  late final String userName;
  late final String userEmail;
  late final String userLocation;
  late final String userBio;

  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userLocation,
    required this.userBio,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    userName = json!['name'];
    userEmail = json['email'];
    userLocation = json['location'];
    userBio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': userName,
      'email': userEmail,
      'location': userLocation,
      'bio': userBio,
    };
  }
}
