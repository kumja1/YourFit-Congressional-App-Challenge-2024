// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:yourfit/src/screens/main_screen.dart' as _i4;
import 'package:yourfit/src/screens/other/auth/reset_password_screen.dart'
    as _i6;
import 'package:yourfit/src/screens/other/auth/signin_screen.dart' as _i9;
import 'package:yourfit/src/screens/other/auth/signup_screen.dart' as _i10;
import 'package:yourfit/src/screens/other/landing_screen.dart' as _i3;
import 'package:yourfit/src/screens/other/settings_screen.dart' as _i8;
import 'package:yourfit/src/screens/other/splash_screen.dart' as _i11;
import 'package:yourfit/src/screens/tabs/exercises_screen.dart' as _i1;
import 'package:yourfit/src/screens/tabs/friends_screen.dart' as _i2;
import 'package:yourfit/src/screens/tabs/profile_screen.dart' as _i5;
import 'package:yourfit/src/screens/tabs/roadmap_screen.dart' as _i7;

/// generated route for
/// [_i1.ExercisesScreen]
class ExercisesRoute extends _i12.PageRouteInfo<void> {
  const ExercisesRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ExercisesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExercisesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i1.ExercisesScreen();
    },
  );
}

/// generated route for
/// [_i2.FriendsScreen]
class FriendsRoute extends _i12.PageRouteInfo<void> {
  const FriendsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          FriendsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FriendsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.FriendsScreen();
    },
  );
}

/// generated route for
/// [_i3.LandingScreen]
class LandingRoute extends _i12.PageRouteInfo<void> {
  const LandingRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i3.LandingScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i12.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i13.Key? key,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ProfileRouteArgs>(orElse: () => const ProfileRouteArgs());
      return _i5.ProfileScreen(key: args.key);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.ResetPasswordScreen]
class ResetPasswordRoute extends _i12.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i6.ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i7.RoadmapScreen]
class RoadmapRoute extends _i12.PageRouteInfo<void> {
  const RoadmapRoute({List<_i12.PageRouteInfo>? children})
      : super(
          RoadmapRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoadmapRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.RoadmapScreen();
    },
  );
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i9.SigninScreen]
class SigninRoute extends _i12.PageRouteInfo<void> {
  const SigninRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SigninScreen();
    },
  );
}

/// generated route for
/// [_i10.SignupScreen]
class SignupRoute extends _i12.PageRouteInfo<void> {
  const SignupRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i10.SignupScreen();
    },
  );
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i11.SplashScreen();
    },
  );
}
