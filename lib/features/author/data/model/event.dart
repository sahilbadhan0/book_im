class Authors {
  bool isAlive;
  List<String> emails;
  List<String> phones;
  String sId;
  Name name;
  String displayName;
  String address;
  String country;
  String birthday;
  String about;
  String gender;
  String profilePictureUrl;
  String facebookProfileUrl;
  String createdAt;
  String updatedAt;
  int iV;

  Authors(
      {this.isAlive,
        this.emails,
        this.phones,
        this.sId,
        this.name,
        this.displayName,
        this.address,
        this.country,
        this.birthday,
        this.about,
        this.gender,
        this.profilePictureUrl,
        this.facebookProfileUrl,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Authors.fromJson(Map<String, dynamic> json) {
    isAlive = json['isAlive'];
    emails = json['emails'].cast<String>();
    phones = json['phones'].cast<String>();
    sId = json['_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    displayName = json['displayName'];
    address = json['address'];
    country = json['country'];
    birthday = json['birthday'];
    about = json['about'];
    gender = json['gender'];
    profilePictureUrl = json['profilePictureUrl'];
    facebookProfileUrl = json['facebookProfileUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAlive'] = this.isAlive;
    data['emails'] = this.emails;
    data['phones'] = this.phones;
    data['_id'] = this.sId;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['displayName'] = this.displayName;
    data['address'] = this.address;
    data['country'] = this.country;
    data['birthday'] = this.birthday;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['profilePictureUrl'] = this.profilePictureUrl;
    data['facebookProfileUrl'] = this.facebookProfileUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Name {
  String middle;
  String first;
  String last;

  Name({this.middle, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    middle = json['middle'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['middle'] = this.middle;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}