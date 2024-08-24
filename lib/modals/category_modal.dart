class CategoryModal {
  final String catId;
  final String catImage;
  final String catName;
  final dynamic createAt;
  final dynamic updatedAt;

  CategoryModal(
      {required this.catId,
      required this.catImage,
      required this.catName,
      required this.createAt,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'catID': catId,
      'catImage': catImage,
      'catName': catName,
      'createAt': createAt,
      'updatedAt': updatedAt,
    };
  }

  factory CategoryModal.fromMap(Map<String, dynamic> json) {
    return CategoryModal(
        catId: json['catId'],
        catImage: json['catImage'],
        catName: json['catName'],
        createAt: json['createAt'],
        updatedAt: json['updatedAt']);
  }
}
