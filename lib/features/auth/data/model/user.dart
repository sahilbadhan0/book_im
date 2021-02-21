import 'package:book_im/features/auth/data/model/profile_ficture.dart';

class User {
  String userId;
  String token;
  String email;
  String name;
  String phone;
  String profilePic ;
  
  
  // ProfilePicture  profilePicture;


  User(
      {this.token,
        this.email,
        this.userId,
        this.name,
        this.phone,
        this.profilePic
        // this.profilePicture,
   });

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
 
    // profilePicture = json['profilePicture'] != null
    //     ? new ProfilePicture.fromJson(json['profilePicture'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['profile_pic'] = this.profilePic;
    //
    // if (this.profilePicture != null) {
    //   data['profilePicture'] = this.profilePicture.toJson();
    // }
    return data;
  }
}


