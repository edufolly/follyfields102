import 'package:follyfields102/models/product_model.dart';

import 'abstract_http_consumer.dart';

class ProductConsumer extends AbstractHttpConsumer<ProductModel> {
  ProductConsumer() : super(<String>['product']);

  @override
  ProductModel fromJson(Map<String, dynamic> map) {
    return ProductModel.fromJson(map);
  }
}
