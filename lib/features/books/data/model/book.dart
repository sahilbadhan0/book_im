class Books {
  String sId;
  String title;
  String author;
  String description;
  String iSBN10;
  String iSBN13;
  int publishedYear;
  String publisher;
  String language;
  List<String> categories;
  int pageCount;
  String image;
  String createdAt;
  String updatedAt;
  int iV;

  Books(
      {this.sId,
        this.title,
        this.author,
        this.description,
        this.iSBN10,
        this.iSBN13,
        this.publishedYear,
        this.publisher,
        this.language,
        this.categories,
        this.pageCount,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Books.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    iSBN10 = json['ISBN10'];
    iSBN13 = json['ISBN13'];
    publishedYear = json['publishedYear'];
    publisher = json['publisher'];
    language = json['language'];
    categories = json['categories'].cast<String>();
    pageCount = json['pageCount'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['ISBN10'] = this.iSBN10;
    data['ISBN13'] = this.iSBN13;
    data['publishedYear'] = this.publishedYear;
    data['publisher'] = this.publisher;
    data['language'] = this.language;
    data['categories'] = this.categories;
    data['pageCount'] = this.pageCount;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}