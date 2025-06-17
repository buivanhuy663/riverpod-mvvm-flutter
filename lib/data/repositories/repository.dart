import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/data_source.dart';
import 'auth_repository.dart';
import 'home_repository.dart';

final repositoryProvider = Provider<Repository>(
  (ref) => throw UnimplementedError(),
);

class Repository {
  Repository(DataSource dataSource) {
    auth = AuthRepository(dataSource);
    home = HomeRepository(dataSource);
  }

  late AuthRepository auth;

  late HomeRepository home;
}
