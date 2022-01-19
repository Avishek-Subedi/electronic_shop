import 'package:electronic_shop/entiies/product_model.dart';
import 'package:electronic_shop/repositories/product_repository.dart';
import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';

enum FilterBy {
  price,
  category,
}

class ProductsProvider with ChangeNotifier {
  ProductModel productsList = ProductModel();
  List<Product> cartProducts = [];
  num totalPrice = 0;
  final _productRepo = ProductRepository();
  bool loading = false;

  getProducts() async {
    loading = true;
    notifyListeners();
    final response = await _productRepo.getProducts();
    if (response.success) {
      productsList = response.data as ProductModel;
      loading = false;
    }
    notifyListeners();
  }

  filterProducts(FilterBy? filterBy) async {
    if (filterBy != null) {
      loading = true;
      notifyListeners();
      final response = await _productRepo.getProducts();
      if (response.success) {
        productsList = response.data as ProductModel;
        loading = false;
        final products = productsList.data?.product;
        products?.sort((a, b) {
          final priceA = int.parse(a.price?.replaceAll('\$', '') ?? '');
          final priceB = int.parse(b.price?.replaceAll('\$', '') ?? '');
          return priceA.compareTo(priceB);
        });
        productsList = ProductModel(
          message: productsList.message,
          results: productsList.results,
          status: productsList.status,
          data: Data(
            product: products,
          ),
        );
        notifyListeners();
      }
    }
  }

  addToCart(Product product) {
    final price = int.parse(product.price?.replaceAll('\$', '') ?? '');
    if (cartProducts.contains(product)) {
      cartProducts.remove(product);
      totalPrice = totalPrice - price;
      notifyListeners();
    } else {
      cartProducts.add(product);
      totalPrice = totalPrice + price;
      notifyListeners();
    }
  }
}
