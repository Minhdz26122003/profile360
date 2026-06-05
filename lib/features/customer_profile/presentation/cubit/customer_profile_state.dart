import 'package:democart/features/customer_profile/domain/entities/customer_profile_data.dart';
import 'package:equatable/equatable.dart';

abstract class CustomerProfileState extends Equatable {
  const CustomerProfileState();

  @override
  List<Object?> get props => [];
}

class CustomerProfileInitial extends CustomerProfileState {
  const CustomerProfileInitial();
}

class CustomerProfileLoading extends CustomerProfileState {
  const CustomerProfileLoading();
}

class CustomerProfileLoaded extends CustomerProfileState {
  const CustomerProfileLoaded(this.data);

  final CustomerProfileData data;

  @override
  List<Object?> get props => [data];
}

class CustomerProfileError extends CustomerProfileState {
  const CustomerProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
