class ProductModal {
  final String catId;
  final String catName;
  final String productId;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productSalePrice;
  final List productImage;
  final bool isSale;
  final dynamic createAt;
  final String deliveryTime;

  ProductModal( 
      {required this.productImage,
        required this.catId,
      required this.catName,
      required this.productId,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productSalePrice,
      required this.isSale,
      required this.createAt,
      required this.deliveryTime});

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'catName': catName,
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productImage': productImage,
      'productPrice': productPrice,
      'productSalePrice': productSalePrice,
      'isSale': isSale,
      'createAt': createAt,
      'deliveryTime': deliveryTime
    };
  }

  factory ProductModal.fromMap(Map<String, dynamic> json) {
    return ProductModal(
        catId: json['catId'],
        catName: json['catName'],
        productId: json['productId'],
        productName: json['productName'],
        productImage:json['productImage'],
        productDescription: json['productDescription'],
        productPrice: json['productPrice'],
        productSalePrice: json['productSalePrice'],
        isSale: json['isSale'],
        createAt: json['createAt'],
        deliveryTime: json['deliveryTime']);
  }
}
