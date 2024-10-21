// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../app_router.dart' as _i342;
import '../functions/auth_service.dart' as _i1007;
import '../functions/user_service.dart' as _i180;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i342.AppRouter>(() => _i342.AppRouter());
    gh.singleton<_i180.UserService>(() => _i180.UserService());
    gh.singleton<_i1007.AuthService>(
        () => _i1007.AuthService(gh<_i180.UserService>()));
    return this;
  }
}
