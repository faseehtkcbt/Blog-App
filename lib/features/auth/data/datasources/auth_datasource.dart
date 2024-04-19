import 'package:blog_app/core/failures/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get userSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  @override
  // TODO: implement userSession
  Session? get userSession => supabaseClient.auth.currentSession;
  AuthRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    // TODO: implement signUpWithEmailPassword
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (userSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select('id,name')
            .eq('id', userSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: userSession!.user.email);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
