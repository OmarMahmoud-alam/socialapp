class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? cover;
  String? bio;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.cover,
    this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'bio': bio,
    };
  }
}
