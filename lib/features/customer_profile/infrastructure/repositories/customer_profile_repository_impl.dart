import 'package:democart/features/customer_profile/domain/entities/customer_activity_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_booking_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_profile_data.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_profile_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_service_model.dart';
import 'package:democart/features/customer_profile/infrastructure/repositories/customer_profile_repository.dart';

class CustomerProfileRepositoryImpl extends CustomerProfileRepository {
  @override
  Future<CustomerProfileData> loadProfile({required String customerId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return const CustomerProfileData(
      profile: CustomerProfileModel(
        id: '1',
        name: 'Nguyễn Thị Như Ý',
        code: 'CUS709980',
        phone: '0376201376',
        gender: 'Nam',
        birthYear: '1997',
        region: 'TP. Hồ Chí Minh',
        status: 'new',
      ),
      latestBooking: CustomerBookingModel(
        bookingCode: 'BOOK-260502-00328',
        branch: 'BỆNH VIỆN KANGNAM SÀI GÒN',
        status: 'Chờ thu tiền',
        createdAt: '31/05/2026 09:37',
      ),
      latestServices: CustomerServiceModel(
        services: [
          'Áo ngực Mỹ size S (XS/M/L)',
          'Xeragel (10g/tuýp)',
          'Túi ngực Nano Motiva (Chip linh hoạt)',
          'Nâng ngực 4D (nano)',
          'Keo dán da Dermabond (hộp 12 ống 0.5ml)',
        ],
      ),
      //transactions: [],
      activities: [
        CustomerActivityModel(
          type: ActivityType.booking,
          code: 'BOOK-260502-00328',
          branch: 'KANGNAM',
          status: 'Chờ thu tiền',
          date: '31/05/2026 09:37',
        ),
        CustomerActivityModel(
          type: ActivityType.examination,
          code: 'PK-2026-114335',
          branch: 'BỆNH VIỆN KANGNAM SÀI GÒN',
          status: 'Đã xác nhận',
          date: '31/05/2026 09:50',
        ),
        CustomerActivityModel(
          type: ActivityType.payment,
          code: 'BOOK-260502-00328',
          branch: 'NGUYỄN THỊ OANH',
          status: 'Chờ thanh toán',
          date: '31/05/2026 18:05',
          amount: '400.000 VND',
        ),
        CustomerActivityModel(
          type: ActivityType.payment,
          code: 'BOOK-260502-00322',
          branch: 'NGUYỄN VĂN HOÀNG',
          status: 'Chờ thanh toán',
          date: '11/05/2026 18:05',
          amount: '4.000.000 VND',
        ),
      ],
    );
  }
}
