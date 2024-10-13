import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './user_service.dart';
import 'package:yourfit/services/models/user_data.dart';

@singleton
class AuthService {
  UserData? currentUser;

  late UserService _userService;
  final _auth = Supabase.instance.client.auth;

  AuthService(UserService userService) {
    _userService = userService;
  }

  @postConstruct
  void init() async {
    try {
      AuthResponse response = await _auth.refreshSession();
      currentUser = await _userService.getUser(response.user!.id);
    } catch (_) {}
  }

  Future<AuthResponse?> signInWithEmail({
    String? password,
    String? email,
  }) async {
    AuthResponse response;

    try {
      response =
          await _auth.signInWithPassword(email: email, password: password!);
    } on Exception catch (_) {
      return null;
    }

    currentUser = await _userService.getUser(response.user!.id);

    return response;
  }

  Future<void> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    int age,
    double height,
  ) async {
    User user = (await _auth.signUp(email: email, password: password)).user!;

    if (user.identities == null || user.identities!.isEmpty)
      throw "User already exist!";

    currentUser =
        _userService.createUser(user.id, firstName, lastName, height, age);
  }

  Future<AuthResponse?> signInWithOAuth(
    OAuthProvider authProvider,
  ) async {
    try {
      var response = switch (authProvider) {
        (OAuthProvider.google) => await _signInWithGoogle(),
        _ => null // This will never be null
      }!;
      currentUser = await _userService.getUser(response.user!.id);
      return response;
    } catch (_) {
      return null;
    }
  }

  Future<AuthResponse> _signInWithGoogle() async {
    var googleUser = await GoogleSignIn(
            clientId:
                "49363448521-ka0refci22k8s3mvvkq1uisdbn06g6vh.apps.googleusercontent.com",
            serverClientId:
                "49363448521-20k81sovvas4r2aji7nhrd6sbe0pb0b1.apps.googleusercontent.com")
        .signIn();

    var googleAuth = await googleUser!.authentication;
    var accessToken = googleAuth.accessToken;
    var idToken = googleAuth.idToken;

    if (accessToken == null && idToken == null) {
      throw AuthException("The access and id tokens are null");
    }

    var response = await _auth.signInWithIdToken(
      idToken: idToken!,
      accessToken: accessToken,
      provider: OAuthProvider.google,
    );

    return response;
  }

  @disposeMethod
  dispose() {}
}
