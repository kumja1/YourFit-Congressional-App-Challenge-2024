import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'user_service.dart';
import 'package:yourfit/src/services/models/user_data.dart';

@singleton
class AuthService {
  UserData? currentUser;

  late UserService _userService;
  final _auth = Supabase.instance.client.auth;

  AuthService(UserService userService) {
    _userService = userService;
  }

  Future<void> init() async {
    try {
      var session = await _auth.refreshSession();
      currentUser = await _userService.getUser(session.user!.id);
      _auth.onAuthStateChange.listen(_onAuthStateChange);
    } catch (_) {}
  }

  Future<void> loadSession() async {
    AuthResponse response = await _auth.refreshSession();
    if (response.user != null) {
      currentUser = await _userService.getUser(response.user!.id);
    }
  }

  Future<bool> signInWithEmail({
    String? password,
    String? email,
    required Function(AuthException error) onError,
  }) async {
    try {
      AuthResponse response =
          await _auth.signInWithPassword(email: email, password: password!);
      currentUser = await _userService.getUser(response.user!.id);
      return true;
    } on AuthException catch (e) {
      onError(e);
      return false;
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String firstName,
    String lastName,
    int age,
    int height,
    double weight,
    Function(Exception error) onError,
  ) async {
    try {
      User user = (await _auth.signUp(email: email, password: password)).user!;

      if (user.identities == null || user.identities!.isEmpty) {
        onError(AuthException("User already exist!"));
        return;
      }

      currentUser = _userService.createUser(
          user.id, firstName, lastName, weight, height, age);
    } on AuthException catch (e) {
      onError(e);
    }
  }

  Future<void> signInWithOAuth(
    OAuthProvider authProvider,
  ) async {
    try {
      var response = switch (authProvider) {
        (OAuthProvider.google) => await _signInWithGoogle(),
        _ => null // This will never be null
      }!;
      currentUser = await _userService.getUser(response.user!.id);
    } catch (_) {}
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

  Future<void> resetPassword(String email) async =>
      await _auth.resetPasswordForEmail(email);

  void _onAuthStateChange(AuthState event) async {
    // switch (event.event) {
    //  case AuthChangeEvent.userUpdated:
        currentUser = await _userService.getUser(event.session!.user.id);
    }
  }
// }
