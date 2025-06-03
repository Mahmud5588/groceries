import 'package:equatable/equatable.dart';
import 'package:groceries/features/authentication/domain/entities/user_entites.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserEntities user;

  const UserProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserProfileUpdateSuccess extends UserProfileState {
  final String message;

  const UserProfileUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
