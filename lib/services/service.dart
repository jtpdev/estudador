import 'package:estudador/models/model.dart';

abstract class Service<T extends Model> {

  Future<void> save(T model);

  Future<void> update(int index, T model);

  Future<List<T>> list();

  Future<T> load(int index);

}