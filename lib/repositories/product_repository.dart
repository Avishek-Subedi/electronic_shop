import 'dart:convert';

import 'package:electronic_shop/entiies/base_response.dart';
import 'package:electronic_shop/entiies/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<BaseResponse> getProducts() async {
    const imageUrl =
        'https://electronic-ecommerce.herokuapp.com/fantechHeadset.jpg';
    try {
      var response = await http.get(Uri.parse(
          'https://electronic-ecommerce.herokuapp.com/api/v1/product'));

      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      final result = ProductModel.fromJson(decodedResponse);

      return BaseResponse(
        data: ProductModel(
          message: result.message,
          status: result.status,
          results: result.results,
          data: Data(
            product: result.data?.product
                ?.map((e) => e.copyWith(image: imageUrl))
                .toList(),
          ),
        ),
        error: null,
        success: true,
      );
    } catch (e) {
      return BaseResponse(data: null, error: e.toString(), success: false);
    }
  }
}
