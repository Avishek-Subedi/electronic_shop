class ProductModel {
  String? status;
  int? results;
  Data? data;
  String? message;

  ProductModel({this.status, this.results, this.data, this.message});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['results'] = results;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }

  ProductModel copyWith({
    String? status,
    int? results,
    Data? data,
    String? message,
  }) {
    return ProductModel(
      status: status ?? this.status,
      results: results ?? this.results,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class Data {
  List<Product>? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Data copyWith({
    List<Product>? product,
  }) {
    return Data(
      product: product ?? this.product,
    );
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  String? price;
  int? stock;
  int? createDate;
  List<String>? category;

  Product({
    this.id,
    this.name,
    this.image,
    this.price,
    this.stock,
    this.createDate,
    this.category,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    stock = json['stock'];
    createDate = json['createDate'];
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['stock'] = stock;
    data['createDate'] = createDate;
    data['category'] = category;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          category == other.category;

  @override
  int get hashCode => id.hashCode ^ id.hashCode;

  Product copyWith({
    int? id,
    String? name,
    String? image,
    String? price,
    int? stock,
    int? createDate,
    List<String>? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      createDate: createDate ?? this.createDate,
      category: category ?? this.category,
    );
  }
}
