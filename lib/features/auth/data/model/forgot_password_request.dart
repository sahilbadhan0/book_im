class ForgotPasswordRequest {
  String userName;
  String password;

  ForgotPasswordRequest(
      {this.userName,
        this.password});

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    userName = json['email'];
    password = json['password'];
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}