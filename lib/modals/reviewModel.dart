// ignore_for_file: file_names

class Reviewmodel {
  final String reviewId;
  final double rate;
  final String feedback;
  final String productId;
  final String productName;
  final String customerName;
  final dynamic createdAt;

  Reviewmodel( 
      {required this.reviewId,
      required this.rate,
      required this.productId,
      required this.feedback,
      required this.productName,
      required this.customerName,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'rate': rate,
      'productId': productId,
      'feedback': feedback,
      'productName': productName,
      'customerName': customerName,
      'createdAt': createdAt,
    };
  }

  factory Reviewmodel.fromMap(Map<String, dynamic> json) {
    return Reviewmodel(
      reviewId: json['reviewId'],
      rate: json['rate'],
      feedback: json['feedback'],
      productId: json['productId'],
      productName: json['productName'],
      customerName: json['customerName'],    
      createdAt: json['createdAt'],
    );
  }

  
}
