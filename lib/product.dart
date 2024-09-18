class Product {
  final String id;
  final String productName;
  final String productCode;
  final String ProductImage;
  final String unitPrice;

  final String quantity;
  final String TotalPrice;
  final String createAt;

  Product(
      {required this.id,
        required this.productName,
        required this.productCode,
        required this.ProductImage,
        required this.unitPrice,
        required this.quantity,
        required this.TotalPrice,
        required this.createAt});

  factory Product.tojson(Map<String,dynamic>e){
    return Product(
        id:e['_id'] ,
        productName: e['ProductName'],
        productCode: e['ProductName'],
        ProductImage: e['Img'],
        unitPrice: e['UnitPrice'],
        quantity: e['Qty'],
        TotalPrice: e['TotalPrice'],
        createAt: e['CreatedDate']);

  }
}