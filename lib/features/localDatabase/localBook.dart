class LocalBook {
  String id ;
  String path;
  String image;
  String size;
  String name;

  LocalBook(
      {this.id,this.name,this.image,this.path,this.size,});

  LocalBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    name = json['name'];
    size = json['size'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id']=this.id;
     data['path']=this.path;
     data['name']=this.name;
     data['size']=this.size;
     data['image']=this.image;
    return data;
  }
}