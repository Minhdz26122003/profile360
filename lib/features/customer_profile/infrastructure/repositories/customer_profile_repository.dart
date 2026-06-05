import 'package:democart/features/customer_profile/domain/entities/customer_profile_data.dart';

abstract class CustomerProfileRepository {
  Future<CustomerProfileData> loadProfile({required String customerId});
}
