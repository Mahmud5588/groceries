import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceries/features/authentication/domain/entities/api_response.dart';
import 'package:groceries/features/authentication/domain/usecase/get_user_usecase.dart' show GetUserUseCase;
import 'package:groceries/features/authentication/presentation/bloc/user/user_event.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserUseCase _getUserUseCase;

  UserProfileBloc({
    required GetUserUseCase getUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        super(UserProfileInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfile event,
      Emitter<UserProfileState> emit,
      ) async {
    emit(UserProfileLoading());
    try {
      final ApiResponse response = await _getUserUseCase();
      if (response.userEntities != null) {
        emit(UserProfileLoaded(response.userEntities!));
      } else {
        emit(UserProfileError(response.error ?? response.message ?? 'Foydalanuvchi ma\'lumotlarini yuklab bo\'lmadi'));
      }
    } catch (e) {
      emit(UserProfileError('Foydalanuvchi ma\'lumotlarini yuklashda xatolik: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfile event,
      Emitter<UserProfileState> emit,
      ) async {
    emit(UserProfileLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      // Corrected typo: event.first_namename -> event.first_name
      print('Updating profile with: ${event.first_name}, ${event.email}, ${event.phone}');
      emit(const UserProfileUpdateSuccess('Ma\'lumotlar (taxminan) yangilandi! Haqiqiy API integratsiyasini kuting.'));
      add(FetchUserProfile());

    } catch (e) {
      emit(UserProfileError('Ma\'lumotlarni yangilashda xatolik: ${e.toString()}'));
    }
  }
}
