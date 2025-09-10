import 'package:dio_jwt_demo/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository{
  Future<UserEntity> login(String email, String password);
  Future<void> cacheToken(String token);
  Future<String?> getCacheToken();
}