import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:follyfields102/models/product_model.dart';

class ProductBuilder extends AbstractUIBuilder<ProductModel> {
  @override
  String plural(BuildContext context) {
    return 'Products';
  }

  @override
  String single(BuildContext context) {
    return 'Product';
  }

  @override
  Widget getLeading(BuildContext context, ProductModel model) => Icon(
        Icons.circle,
        color: model.active ? Colors.green : Colors.red,
      );

  @override
  Widget getTitle(BuildContext context, ProductModel model) {
    return Text(model.code);
  }

  @override
  Widget? getSubtitle(BuildContext context, ProductModel model) {
    return Text(model.description);
  }
}
