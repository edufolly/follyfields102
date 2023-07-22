import 'package:agattp/agattp.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:follyfields102/utils/config.dart';

abstract class AbstractHttpConsumer<T extends AbstractModel<Object>>
    extends AbstractConsumer<T> {
  const AbstractHttpConsumer(super.routeName);

  @override
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  ) async {
    return const ConsumerPermission(
      menu: true,
      view: true,
      insert: true,
      update: true,
      delete: true,
    );
  }

  @override
  Future<T?> getById(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    final Uri uri = Uri.parse([
      Config().server,
      ...routeName,
      model.id.toString(),
    ].join('/'))
        .replace(queryParameters: extraParams);

    final AgattpResponseJson<Map<String, dynamic>> response =
        await Agattp().getJson(uri);

    return fromJson(response.json);
  }

  @override
  Future<List<T>> list(
    BuildContext context, {
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  }) async {
    final Uri uri = Uri.parse([
      Config().server,
      ...routeName,
    ].join('/'))
        .replace(queryParameters: <String, String>{
      'page': page.toString(),
      'size': size.toString(),
      ...extraParams
    });

    final AgattpResponseJson<List<dynamic>> response =
        await Agattp().getJson(uri);

    return response.json.map((dynamic map) => fromJson(map)).toList();
  }

  @override
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    bool isSave = model.id == null;

    Uri uri = Uri.parse([
      Config().server,
      ...routeName,
      if (!isSave) model.id.toString(),
    ].join('/'))
        .replace(queryParameters: extraParams);

    AgattpResponseJson<Map<String, dynamic>> response;

    if (isSave) {
      response = await Agattp().postJson(uri, body: model.toSave());
      return fromJson(response.json).id != null;
    } else {
      response = await Agattp().putJson(uri, body: model.toSave());
      return response.statusCode == 204;
    }
  }

  @override
  Future<bool> delete(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async {
    final Uri uri = Uri.parse([
      Config().server,
      ...routeName,
      model.id.toString(),
    ].join('/'))
        .replace(queryParameters: extraParams);

    final AgattpResponse response = await Agattp().delete(uri);

    return response.statusCode == 204;
  }
}
