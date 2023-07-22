import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_list.dart';
import 'package:follyfields102/consumers/product_consumer.dart';
import 'package:follyfields102/models/product_model.dart';
import 'package:follyfields102/views/builders/product_builder.dart';
import 'package:follyfields102/views/edits/product_edit.dart';

class ProductList
    extends AbstractList<ProductModel, ProductBuilder, ProductConsumer> {
  ProductList({super.key})
      : super(
            selection: false,
            multipleSelection: false,
            showRefreshButton: true,
            consumer: ProductConsumer(),
            uiBuilder: ProductBuilder(),
            onAdd: (
              BuildContext context,
              ProductBuilder uiBuilder,
              ProductConsumer consumer,
            ) async {
              return ProductEdit(
                ProductModel(),
                uiBuilder,
                consumer,
                edit: true,
              );
            },
            onUpdate: (
              BuildContext context,
              ProductModel model,
              ProductBuilder uiBuilder,
              ProductConsumer consumer, {
              required bool edit,
            }) async {
              return ProductEdit(
                model,
                uiBuilder,
                consumer,
                edit: edit,
              );
            });
}
