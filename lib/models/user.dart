
import 'dart:convert';

UserModel  userFromJson(String user) => UserModel.formJsonToObject(json.decode(user));
class UserModel {
  User user;
  String token;
  bool resetPasswordRequest;

  UserModel({ required this.user,required this.token, required this.resetPasswordRequest});


  factory UserModel.formJsonToObject(Map<String, dynamic> json) =>
      UserModel(
            user: User.fromJson(json['user']),
            token: json['token'],
            resetPasswordRequest: json['reset_password_request']
      );

  Map<String,dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
    "reset_password_request": resetPasswordRequest
  };

}
// to create constructor of UserModel use below code
// user = UserModel(String user, String token);

class User{
 final int? userId;
 final String? name;
 final String? userName;
 final String? profileImage;
 final String? email;
 final String? firstName;
 final String? lastName;
 final String? userType;
 final String? mobile;
 final String? biography;
 final int? businessId;
 final bool? resetPasswordRequest;

  User({this.userId, this.name,this.userName, this.email,this.firstName, this.lastName, this.userType ,this.mobile,this.biography,this.profileImage,this.businessId, this.resetPasswordRequest});

  // create new converter
  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        userId: json['id'],
        name: json['name'],
        userName: json['username'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        userType: json['user_type'],
        mobile: json['contact_number'],
        biography: json['biography'],
        profileImage: json['profile_image'],
        businessId: json['business_id'], resetPasswordRequest: json['reset_password_request']
      );

  Map<String,dynamic> toJson() => {
    "id": userId,
    "name": name,
    "username": userName,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "user_type": userType,
    "contact_number": mobile,
    "biography": biography,
    "profile_image": profileImage,
    "business_id": businessId,
    "reset_password_request": resetPasswordRequest
  };

}