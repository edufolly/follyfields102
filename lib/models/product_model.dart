import 'package:folly_fields/crud/abstract_model.dart';

class ProductModel extends AbstractModel<int> {
  String code = '';
  String description = '';
  double price = 0.0;
  DateTime lastPurchase = DateTime.now();
  int stock = 0;
  bool active = true;

  ProductModel();

  ProductModel.fromJson(Map<String, dynamic> map)
      : code = map['code'] ?? '',
        description = map['description'] ?? '',
        price = map['price'] ?? 0.0,
        lastPurchase = DateTime.tryParse(map['lastPurchase']) ?? DateTime.now(),
        stock = map['stock'] ?? 0,
        active = map['active'] ?? true,
        super.fromJson(map);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['code'] = code;
    map['description'] = description;
    map['price'] = price;
    map['lastPurchase'] = lastPurchase.toIso8601String();
    map['stock'] = stock;
    map['active'] = active;
    return map;
  }

  @override
  String toString() => description;
}
