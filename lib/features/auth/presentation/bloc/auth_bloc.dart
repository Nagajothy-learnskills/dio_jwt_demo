import 'package:dio_jwt_demo/features/auth/domain/use_case/login_usecase.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>(_loginRequested);
  }

  Future<void> _loginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try{
      final userEntity  = await loginUseCase.call(event.email, event.password);
      emit(AuthSuccess(userEntity: userEntity));
    }catch(e){
      emit(AuthFailure(message: e.toString() ?? 'Failure to Login'));
    }
  }
}
