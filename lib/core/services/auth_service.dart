import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

import '../utils/constants.dart';
import 'api_service.dart';

class AuthService extends GetxService {
  final GetStorage _getStorage = GetStorage();
  final GoTrueClient auth = Get.find<ApiService>().client!.auth;
  final RxBool _isLogged = false.obs;

  @override
  void onInit() {
    // recover session when doing hot reload
    hydateAuth();
    super.onInit();
  }

  /// Check If Our Session Has Expired
  ///
  /// Avoid Running Async Function Here
  ///
  /// That Would Cause Infinite Loop
  bool isValid() {
    if (expiresAt == 0) {
      return false;
    }
    final timeNow = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    if (expiresAt < timeNow) {
      // inside this scope our token has expired
      return false;
    } else {
      // token is not yet expired
      return true;
    }
  }

  /// Use to Recover Our Session When Token Expired
  ///
  /// refreshToken will always be the same
  ///
  /// expiresAt Will Be Updated when this Function is Triggered
  Future<void> refreshSession() async {
    if (refreshToken != null) {
      final response = await auth.api.refreshAccessToken(refreshToken!);
      final error = response.error;
      if (error != null) {
        _destroySession();
      } else {
        _persistSession(response.data!.persistSessionString);
      }
    }
  }

  /// Persist to Local Storage Our refreshToken
  set refreshToken(String? val) {
    if (val != null) {
      _getStorage.write(SESSION_REFRESH_TOKEN, val);
    } else {
      _getStorage.remove(SESSION_REFRESH_TOKEN);
    }
  }

  /// Get Our refreshToken in Our Local Storage
  String? get refreshToken {
    return _getStorage.read(SESSION_REFRESH_TOKEN);
  }

  /// Our Reactive State In This Class
  ///
  /// Setter for isLogged RxBool
  set isLogged(bool val) {
    _isLogged.value = val;
  }

  /// Get isLogged From Memory
  ///
  /// Getter for IsLogged RxBool
  bool get isLogged {
    return _isLogged.value;
  }

  /// Set expiresAt Value in our Local Storage
  ///
  /// Remove it from Local Storage if Set as 0
  set expiresAt(int? val) {
    if (val != 0) {
      _getStorage.write(SESSION_EXPIRY, val);
    } else {
      _getStorage.remove(SESSION_EXPIRY);
    }
  }

  /// Get expiresAt at Local Storage
  ///
  /// Returns 0 when Not Found On Our Local Storage
  int get expiresAt {
    return _getStorage.read(SESSION_EXPIRY) ?? 0;
  }

  /// Save Session String on Our Local Storage
  // ignore: avoid_setters_without_getters
  set saveSession(String? jsonStr) {
    if (jsonStr != null) {
      _getStorage.write(SESSION_KEY, jsonStr);
    } else {
      _getStorage.remove(SESSION_KEY);
    }
  }

  /// Retrive Our Session from Local Storage
  ///
  /// And Json Decode its Str Value
  ///
  /// Return Null If No Session Key Found
  dynamic get session {
    if (_getStorage.hasData(SESSION_KEY)) {
      final mysession = _getStorage.read(SESSION_KEY) as String;
      return json.decode(mysession) as dynamic;
    } else {
      return null;
    }
  }

  /// Use For Recoverring Session When We Do Hard Refresh
  /// So We Can Use our auth.user().properties
  String? get strSession {
    if (_getStorage.hasData(SESSION_KEY)) {
      return _getStorage.read(SESSION_KEY);
    } else {
      return null;
    }
  }

  /// Use email and Password to Login at Your Supabase Instance
  Future<void> login({String? email, String? password}) async {
    final response = await auth.signIn(email: email, password: password);

    final data = response.data;
    final error = response.error;
    if (error != null) {
      _destroySession();
      Get.snackbar('Signed in Failed', error.message);
    } else {
      _persistSession(data!.persistSessionString);
      Get.offAllNamed('/dashboard');
    }
  }

  /// Register an Email and Password at Your Supabase Instance
  ///
  /// IMPORTANT! Disable Email Confirmation On Supabase Dashboard
  Future<void> register(
      {required String email, required String password}) async {
    final response = await auth.signUp(email, password);
    final error = response.error;
    if (error != null) {
      _destroySession();
      Get.snackbar('Sign Up Failed!', error.message);
    } else {
      _persistSession(response.data!.persistSessionString);
      Get.offAllNamed('/dashboard');
    }
  }

  void _persistSession(String jsonStr) {
    saveSession = jsonStr;
    expiresAt = session['expiresAt'] as int?;
    refreshToken = session['currentSession']['refresh_token'] as String?;
    isLogged = true;
  }

  void _destroySession() {
    saveSession = null;
    isLogged = false;
    refreshToken = null;
    expiresAt = null;
  }

  /// Log You Out to Your Supabase Instance
  ///
  /// And Destroy Current Session in Our Local Storage
  Future<void> signOut() async {
    await auth.signOut();
    _destroySession();
    Get.offAllNamed('/login');
  }

  /// Send A Reset Request to An Email
  ///
  /// We Are Retuning Bool
  ///
  /// So We Can Show Loading Indicator on Button
  Future<bool> recover(String email) async {
    final response = await auth.api.resetPasswordForEmail(email);
    final error = response.error;

    if (error != null) {
      Get.snackbar('Request Failed!', error.message);
      return false;
    } else {
      Get.snackbar(
          'Request Success!', 'Please Check Your Email For Instruction.');
      return true;
    }
  }

  Future<void> hydateAuth() async {
    if (strSession != null) {
      final response = await auth.recoverSession(strSession!);
      if (response.error != null) {
        _destroySession();
      } else {
        _persistSession(response.data!.persistSessionString);
      }
    }
  }
}
