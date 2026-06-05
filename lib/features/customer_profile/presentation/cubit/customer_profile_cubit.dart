import 'package:democart/features/customer_profile/infrastructure/repositories/customer_profile_repository.dart';
import 'package:democart/features/customer_profile/infrastructure/repositories/customer_profile_repository_impl.dart';
import 'package:democart/features/customer_profile/presentation/cubit/customer_profile_state.dart';
import 'package:democart/features/customer_profile/use_cases/load_customer_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef CustomerProfileLoader = Future<dynamic> Function({
  required String customerId,
});

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  CustomerProfileCubit({
    CustomerProfileRepository? repository,
    LoadCustomerProfileUseCase? loadCustomerProfileUseCase,
  }) : _loadCustomerProfileUseCase =
           loadCustomerProfileUseCase ??
           LoadCustomerProfileUseCase(
             repository ?? CustomerProfileRepositoryImpl(),
           ),
       super(const CustomerProfileInitial());

  final LoadCustomerProfileUseCase _loadCustomerProfileUseCase;

  Future<void> loadProfile({
    required String customerId,
    bool isRefresh = false,
  }) async {
    if (!isRefresh) {
      emit(const CustomerProfileLoading());
    }
    try {
      final data = await _loadCustomerProfileUseCase(customerId: customerId);
      emit(CustomerProfileLoaded(data));
    } catch (_) {
      if (!isRefresh) {
        emit(
          const CustomerProfileError(
            'Không tải được hồ sơ khách hàng',
          ),
        );
      }
    }
  }
}
