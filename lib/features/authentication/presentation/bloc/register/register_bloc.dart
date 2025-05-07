import 'package:bloc/bloc.dart';
import 'package:groceries/features/authentication/domain/usecase/register_usecase.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_state.dart';

import '../event.dart' show RegisterEvent;

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await registerUseCase(
          email: event.email,
          first_name: event.first_name,
          last_name: event.last_name,
          password: event.password,
          password_confirmation: event.password_confirmation,
          profile_picture: event.profile_picture,
        );
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
