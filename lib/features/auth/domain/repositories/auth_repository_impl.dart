import 'package:dio_jwt_demo/core/error/exceptions.dart';
import 'package:dio_jwt_demo/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:dio_jwt_demo/features/auth/domain/entities/user_entity.dart';
import 'package:dio_jwt_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<void> cacheToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  @override
  Future<String?> getCacheToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try{
      final userEntity = await authRemoteDataSource.login(email, password);
      // Get the token returned from the remote data source
      final token = userEntity.token;
      // Cache token
      /*await cacheToken(token);
      await authRemoteDataSource.setJwt(token);*/
      return userEntity;
    }on ServerException catch(e){
      throw ServerException(e.message);
    }

  }
  
}