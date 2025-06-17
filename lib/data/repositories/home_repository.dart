import '../services/services.dart';

class HomeRepository {
  HomeRepository(this._services);

  final Services _services;

  Future<dynamic> getData() => _services.dio.getData();
}
