import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/services.dart';
import 'auth_repository.dart';
import 'home_repository.dart';

final repositoryProvider = Provider<Repository>(
  (ref) => throw UnimplementedError(),
);

class Repository {
  Repository(Services services) {
    auth = AuthRepository(services);
    home = HomeRepository(services);
  }

  late AuthRepository auth;

  late HomeRepository home;
}
