// ignore_for_file: file_names

class CartModel {
  final String productId;
  final String catId;
  final String productName;
  final String catName;
  final String productSalePrice;
  final String productPrice;
  final List productImage;
  final String deliveryTime;
  final bool isSale;
  final String productDescription;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int productQuantity;
  final double productTotalPrice;

  CartModel({
    required this.productId,
    required this.catId,
    required this.productName,
    required this.catName,
    required this.productSalePrice,
    required this.productPrice,
    required this.productImage,
    required this.deliveryTime,
    required this.isSale,
    required this.productDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.productQuantity,
    required this.productTotalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'categoryId': catId,
      'productName': productName,
      'categoryName': catName,
      'salePrice': productSalePrice,
      'fullPrice': productPrice,
      'productImage': productImage,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      catId: json['catId'],
      productName: json['productName'],
      catName: json['catName'],
      productSalePrice: json['productSalePrice'],
      productPrice: json['productPrice'],
      productImage: json['productImage'],
      deliveryTime: json['deliveryTime'],
      isSale: json['isSale'],
      productDescription: json['productDescription'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
    );
  }
}