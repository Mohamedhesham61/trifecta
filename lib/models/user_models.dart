class UserModel
{
  String? applyingAs;
  String? gender;
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? profileImage;


  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.profileImage,
    required this.applyingAs,
    required this.gender,
  });
  UserModel.fromJson(Map<String,dynamic>json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    applyingAs = json['applyingAs'];
    gender = json['gender'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId':uId,
      'profileImage':profileImage,
      'applyingAs': applyingAs,
      'gender': gender,
    };
  }
}