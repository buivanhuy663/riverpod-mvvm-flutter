import '../services/data_source.dart';

class HomeRepository {
  HomeRepository(
    this._dataSource,
  );

  final DataSource _dataSource;

  Future<dynamic> getData() => _dataSource.dio.getData();
}
