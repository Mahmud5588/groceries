import 'package:bloc/bloc.dart';
import 'package:groceries/features/authentication/domain/usecase/login_usecase.dart';
import 'package:groceries/features/authentication/presentation/bloc/event.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try{
        final result=await loginUseCase(
          email: event.email,
          password: event.password,
          device_name: event.device_name,
        );
        emit(LoginSuccess(result));
      }catch(e){
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
