import 'package:day01/model/product.dart';
import 'package:dio/dio.dart';

class API {
  Future<List<Product>> getAllProducts() async {
    // Logic to get all products
    var dio = Dio();
    var response = await dio.request('https://fakestoreapi.com/products');
    // var response = await dio.request(
    //   'https://newsapi.org/v2/everything?q=tesla&from=2025-11-05&sortBy=publishedAt&apiKey=63497e3306404d7188ab2c99f8b0df16',
    // );
    List<Product> listProducts = [];

    if (response.statusCode == 200) {
      List data = response.data;
      listProducts = data.map((x) => Product.fromJson(x)).toList();
    } else {
      print('Error');
    }

    return listProducts;
  }
}

var test_api = API();
