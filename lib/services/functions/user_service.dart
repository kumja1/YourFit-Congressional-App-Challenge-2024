import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import '../models/index.dart';

@singleton
class UserService {
  final _supabase = Supabase.instance.client;

  UserData createUser(
    String id,
    String firstName,
    String lastName,
    double height,
    int age,
  ) {
    UserData user = UserData(
      id: id,
      firstName: firstName,
      lastName: lastName,
      age: age,
      height: height,
      caloriesBurned: 0,
      exerciseData: [],
      milesTraveled: 0,
    );


    _supabase.from("user_data").insert(user.toJson());

    return user;
  }

  bool saveUser(UserData user) {
    return false;
  }

  Future<UserData?> getUser(String id) async {
    Map<String, dynamic> response;
    try {
      response = (await _supabase.from("user_data")
      .select()
      .eq("id", id))
      .first;
    } catch (_) {
      return null;
    }

    return UserData.fromJson(response);
  }
}
