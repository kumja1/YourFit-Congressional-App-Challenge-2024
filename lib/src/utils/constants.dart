import 'package:get_it/get_it.dart';
import 'package:zod_validation/zod_validation.dart';

final getIt = GetIt.I;

final emailValidator =
    Zod().required("Email is required").email("Invalid email address");
