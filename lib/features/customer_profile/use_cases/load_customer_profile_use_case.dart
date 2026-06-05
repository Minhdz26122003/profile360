import 'package:democart/features/customer_profile/domain/entities/customer_profile_data.dart';
import 'package:democart/features/customer_profile/infrastructure/repositories/customer_profile_repository.dart';

class LoadCustomerProfileUseCase {
  const LoadCustomerProfileUseCase(this._repository);

  final CustomerProfileRepository _repository;

  Future<CustomerProfileData> call({required String customerId}) {
    return _repository.loadProfile(customerId: customerId);
  }
}
