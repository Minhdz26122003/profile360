import 'package:democart/features/cart/presentation/cubit/scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerDialog extends StatefulWidget {
  const ScannerDialog({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<ScannerCubit>(context),
        child: const ScannerDialog(),
      ),
    );
  }

  @override
  State<ScannerDialog> createState() => _ScannerDialogState();
}

class _ScannerDialogState extends State<ScannerDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [BarcodeFormat.qrCode],
    );

    context.read<ScannerCubit>().startScan();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Quét Mã QR Đơn Hàng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hướng camera về phía mã QR của khách hàng',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 32),
            BlocConsumer<ScannerCubit, ScannerState>(
              listener: (context, state) {
                if (state is ScannerSuccess) {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đã xác nhận thành công đơn: ${state.bookingId}',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: MobileScanner(
                              controller: _scannerController,
                              onDetect: (BarcodeCapture capture) {
                                final barcode = capture.barcodes.firstOrNull;
                                if (barcode != null &&
                                    barcode.rawValue != null) {
                                  context.read<ScannerCubit>().onScanSuccess(
                                    barcode.rawValue!,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: _buildCorner(top: true, left: true),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: _buildCorner(top: true, left: false),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: _buildCorner(top: false, left: true),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: _buildCorner(top: false, left: false),
                        ),
                        if (state is ScannerSuccess)
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 80,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    if (state is ScannerSuccess) ...[
                      Text(
                        'Tìm thấy mã: ${state.bookingId}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Đang tự động xác nhận...',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ] else ...[
                      const Text(
                        'Bắt đầu quét',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.read<ScannerCubit>().resetScanner();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner({required bool top, required bool left}) {
    const double size = 20;
    const double thickness = 4;

    return Container(
      width: 250,
      height: 250,
      alignment: Alignment(left ? -1.02 : 1.02, top ? -1.02 : 1.02),
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Positioned(
              left: left ? 0 : null,
              right: left ? null : 0,
              top: top ? 0 : null,
              bottom: top ? null : 0,
              child: Container(
                width: size,
                height: thickness,
                color: Colors.blue,
              ),
            ),
            Positioned(
              left: left ? 0 : null,
              right: left ? null : 0,
              top: top ? 0 : null,
              bottom: top ? null : 0,
              child: Container(
                width: thickness,
                height: size,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
