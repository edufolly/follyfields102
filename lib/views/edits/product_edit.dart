import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/bool_field.dart';
import 'package:folly_fields/fields/date_time_field.dart';
import 'package:folly_fields/fields/integer_field.dart';
import 'package:folly_fields/fields/new_decimal_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:follyfields102/consumers/product_consumer.dart';
import 'package:follyfields102/models/product_model.dart';
import 'package:follyfields102/views/builders/product_builder.dart';

class ProductEdit extends AbstractEdit<ProductModel, ProductBuilder,
    ProductConsumer, EmptyEditController<ProductModel>> {
  const ProductEdit(
    super.model,
    super.uiBuilder,
    super.consumer, {
    super.key,
    required super.edit,
  });

  @override
  List<Responsive> formContent(
    BuildContext context,
    model, {
    required bool edit,
    bool Function()? formValidate,
    void Function({required bool refresh})? refresh,
  }) {
    return [
      /// Code
      StringField(
        label: 'Code',
        initialValue: model.code,
        validator: FollyValidators.notBlank,
        onSaved: (String? value) => model.code = value!,
      ),

      /// Description
      StringField(
        label: 'Description',
        initialValue: model.description,
        validator: FollyValidators.notBlank,
        onSaved: (String? value) => model.description = value!,
      ),

      /// Price
      NewDecimalField(
        label: 'Price',
        initialValue: Decimal(doubleValue: model.price, precision: 2),
        validator: FollyValidators.decimalGTEZero,
        onSaved: (Decimal? value) => model.price = value!.doubleValue,
      ),

      /// Last Purchase
      DateTimeField(
        label: 'Last Purchase',
        initialValue: model.lastPurchase,
        onSaved: (DateTime? value) => model.lastPurchase = value!,
      ),

      /// Stock
      IntegerField(
        label: 'Stock',
        initialValue: model.stock,
        validator: FollyValidators.intGTEZero,
        onSaved: (int? value) => model.stock = value!,
      ),

      /// Active
      BoolField(
        label: 'Active',
        initialValue: model.active,
        onSaved: (bool? value) => model.active = value!,
      )
    ];
  }
}
