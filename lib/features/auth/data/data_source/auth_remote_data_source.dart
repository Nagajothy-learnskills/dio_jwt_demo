import 'package:dio/dio.dart';
import 'package:dio_jwt_demo/core/error/exceptions.dart';
import 'package:dio_jwt_demo/core/network/api_client.dart';
import 'package:dio_jwt_demo/core/util/api_constants.dart';
import 'package:dio_jwt_demo/features/auth/domain/entities/user_entity.dart';
abstract class AuthRemoteDataSource{
  Future<UserEntity> login(String userName, String password);
  Future<void> setJwt(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<UserEntity> login(String userName, String password) async{
    try{
      final response =  await apiClient.post(ApiConstants.loginUrl,
      data: {
        'username' : userName,
        'password' : password,
        "expiresInMins": 30,// optional
      });
      if(response.statusCode == 200){
        final accessToken = response.data['accessToken'];
        final id = response.data['id'].toString();
      final email = response.data['email'];
    return UserEntity(id: id, email: email,token: accessToken);
      }else{
        print('Login Failed: ${response.statusCode}');
        throw ServerException('Login Failed: ${response.statusCode}');
      }
    }on DioException catch(e){
      print('Login Failed: ${e.toString()}');
      throw ServerException(e.message ?? '');
    }
  }

  @override
  Future<void> setJwt(String token) async{
     apiClient.setJwt(token);
  }
  
}