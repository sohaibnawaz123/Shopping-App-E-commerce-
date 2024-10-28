// ignore_for_file: file_names

class Ordermodel {
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
  final String customerId;
  final bool orderStatus;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerDeviceToken;

  Ordermodel(
      {required this.productId,
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
      required this.customerId,
      required this.orderStatus,
      required this.customerName,
      required this.customerPhone,
      required this.customerAddress,
      required this.customerDeviceToken});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'catId': catId,
      'productName': productName,
      'catName': catName,
      'productSalePrice': productSalePrice,
      'productPrice': productPrice,
      'productImage': productImage,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'customerId': customerId,
      'orderStatus': orderStatus,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'customerDeviceToken': customerDeviceToken
    };
  }

  factory Ordermodel.fromMap(Map<String, dynamic> json) {
    return Ordermodel(
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
      customerId: json['customerId'],
      orderStatus: json['orderStatus'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      customerDeviceToken: json['customerDeviceToken'],
    );
  }
}
