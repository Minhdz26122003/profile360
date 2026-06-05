import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_bloc.dart';
import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_event.dart';
import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_state.dart';
import 'package:democart/features/cart/presentation/widgets/booking_cart_card.dart';
import 'package:democart/features/shared/scanner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceptionistCartScreen extends StatefulWidget {
  const ReceptionistCartScreen({super.key});

  @override
  State<ReceptionistCartScreen> createState() => _ReceptionistCartScreenState();
}

class _ReceptionistCartScreenState extends State<ReceptionistCartScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CartListBloc>().add(LoadCartList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF4FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Giỏ của Hương Giang',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF555555),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Giỏ hàng của lễ tân',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0F52BA),
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                _searchController.clear();
                                context.read<CartListBloc>().add(RefreshCartList());
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.refresh,
                                  size: 28,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2EAF2), width: 1),
                ),
                child: BlocBuilder<CartListBloc, CartListState>(
                  builder: (context, state) {
                    String hintText = 'Tìm kiếm theo tên khách hàng';
                    if (state is CartListLoaded) {
                      switch (state.searchType) {
                        case SearchType.phoneNumber:
                          hintText = 'Tìm kiếm số điện thoại';
                          break;
                        case SearchType.booking:
                          hintText = 'Tìm kiếm booking';
                          break;
                        case SearchType.customerName:
                          hintText = 'Tìm kiếm theo tên khách hàng';
                          break;
                      }
                    }
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showSearchTypeBottomSheet(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Icon(
                              Icons.menu,
                              color: Colors.black87,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              context.read<CartListBloc>().add(SearchCartList(value));
                            },
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 2),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Icon(
                            Icons.phone,
                            color: Colors.black87,
                            size: 22,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CartListBloc, CartListState>(
                builder: (context, state) {
                  if (state is CartListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CartListLoaded) {
                    final carts = state.filteredCarts;
                    if (carts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 72,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Không tìm thấy giỏ hàng nào',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (state.searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Cho từ khóa: "${state.searchQuery}"',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: carts.length,
                      padding: const EdgeInsets.only(bottom: 80),
                      itemBuilder: (context, index) {
                        final cart = carts[index];
                        return BookingCartCard(cart: cart, onConfirm: () {});
                      },
                    );
                  }
                  if (state is CartListError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScannerDialog.show(context);
        },
        backgroundColor: const Color(0xFF0F3E6D),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
      ),
    );
  }

  void _showSearchTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: context.read<CartListBloc>(),
          child: const SearchTypeBottomSheet(),
        );
      },
    );
  }
}

class SearchTypeBottomSheet extends StatelessWidget {
  const SearchTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF0F52BA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Center(
                  child: Text(
                    'Tìm kiếm theo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CartListBloc, CartListState>(
            builder: (context, state) {
              SearchType currentType = SearchType.customerName;
              if (state is CartListLoaded) {
                currentType = state.searchType;
              }
              return Column(
                children: [
                  _buildOptionRow(
                    context,
                    title: 'Số điện thoại',
                    type: SearchType.phoneNumber,
                    selected: currentType == SearchType.phoneNumber,
                  ),
                  const Divider(height: 1, color: Color(0xFFE2EAF2)),
                  _buildOptionRow(
                    context,
                    title: 'Booking',
                    type: SearchType.booking,
                    selected: currentType == SearchType.booking,
                  ),
                  const Divider(height: 1, color: Color(0xFFE2EAF2)),
                  _buildOptionRow(
                    context,
                    title: 'Tên khách hàng',
                    type: SearchType.customerName,
                    selected: currentType == SearchType.customerName,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildOptionRow(
    BuildContext context, {
    required String title,
    required SearchType type,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        context.read<CartListBloc>().add(UpdateSearchType(type));
        Future.delayed(const Duration(milliseconds: 150), () {
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF1E88E5)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        height: 11,
                        width: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
