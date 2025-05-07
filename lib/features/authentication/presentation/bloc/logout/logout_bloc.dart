import 'package:bloc/bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/event.dart';
import 'package:groceries/features/authentication/presentation/bloc/logout/logout_state.dart';

import '../../../domain/usecase/logout_usecase.dart' show LogoutUseCase;

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutUseCase logoutUseCase;

  LogoutBloc(this.logoutUseCase) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        final result = await logoutUseCase();
        emit(LogoutSuccess(result));
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
  }
}
