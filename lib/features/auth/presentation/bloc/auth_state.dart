import 'package:dio_jwt_demo/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  @override
  List<Object?> get props => [];
}
class AuthInitial extends AuthState{

}
class AuthLoading extends AuthState{

}
class AuthSuccess extends AuthState{
  final UserEntity userEntity;
  AuthSuccess({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}
class AuthFailure extends AuthState{
  final String message;
  AuthFailure({required this.message});
  @override
  List<Object?> get props => [message];
}