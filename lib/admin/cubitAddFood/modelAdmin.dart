class AddFoodModel {
  String? category;
  String? description;
  String? name;
  String? price;
  String? uid;
  String? url;

  AddFoodModel({
    this.category,
    this.description,
    this.uid,
    this.name,
    this.price,
    this.url,
  });

  AddFoodModel.fromJson(Map<String, dynamic>? json)
  {
    category = json!['category'];
    description = json['description'];
    uid = json['uid'];
    name = json['name'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'category':category,
      'description':description,
      'uid':uid,
      'name':name,
      'price':price,
      'url':url,
    };
  }
  }